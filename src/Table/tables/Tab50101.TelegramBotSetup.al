table 50103 "Telegram Bot Setup"
{
    Caption = 'Telegram Bot Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bot Token"; Text[200])
        {
            DataClassification = SystemMetadata;

        }
        field(2; "Chat ID"; Text[50])
        {
            DataClassification = SystemMetadata;
        }
        field(3; "Last Message"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Telegram API URL"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Telegram Bot Setup"."Bot Token"); // dummy, filled by codeunit
        }
    }

    keys
    {
        key(PK; "Bot Token") { Clustered = true; }
    }
}
