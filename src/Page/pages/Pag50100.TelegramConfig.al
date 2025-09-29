page 50102 "Telegram Config"
{
    PageType = Document;
    SourceTable = "Telegram Bot Setup";
    Caption = 'Telegram Bot Connector';
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            group(Group)
            {
                field("Bot Token"; Rec."Bot Token")
                {
                    ApplicationArea = All;
                }
                field("Chat ID"; Rec."Chat ID")
                {
                    ApplicationArea = All;
                }
                field("Message"; Rec."Last Message")
                {
                    Caption = 'Message';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendMessage)
            {
                Caption = 'Send Message';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = Send;

                trigger OnAction()
                var
                    TelegramHelper: Codeunit "Telegram Helper";
                begin
                    TelegramHelper.SendTelegramMessage(Rec);
                end;
            }
        }
    }
}
