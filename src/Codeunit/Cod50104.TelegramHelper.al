codeunit 50104 "Telegram Helper"
{
    procedure SendTelegramMessage(var BotSetup: Record "Telegram Bot Setup")
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Content: HttpContent;
        Headers: HttpHeaders;
        Url: Text;
        Json: Text;
        Message: Text;
    begin
        Url := StrSubstNo('https://api.telegram.org/bot%1/sendMessage', BotSetup."Bot Token");

        // Escape quotes in message to avoid invalid JSON
        Message := BotSetup."Last Message".Replace('"', '\"');

        Json := '{' +
                '"chat_id": ' + BotSetup."Chat ID" + ',' +
                '"text": "' + BotSetup."Last Message" + '"' +
                '}';

        Content.WriteFrom(Json);
        Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');

        if Client.Post(Url, Content, Response) then begin
            if Response.IsSuccessStatusCode() then
                Message('Message sent successfully!!')
            else begin
                Response.Content.ReadAs(Json);
                Error('Error: %1 - %2', Response.HttpStatusCode, Json);
            end;
        end else
            Error('HTTP request failed.');
    end;
}
