codeunit 50102 ExchangeRate
{
    procedure ExchangeRate(Currency: Record Currency)
    var
        HttpClient: HttpClient;
        HttpResponse: HttpResponseMessage;
        result: Text;
        url: Text;
    begin
        url := 'https://api.primeapi.io/fx/quote?pairs=EUR/USD';
        // Use Bearer token (same as Postman)
        HttpClient.DefaultRequestHeaders.Add('Authorization', 'Bearer 5775ce1bfb-6929c05349-t21kyz');

        if HttpClient.Get(url, HttpResponse) then begin
            HttpResponse.Content.ReadAs(result);
            Message(result);
        end else
            Error('Unable to reach API. URL: %1', url);
    end;
}
