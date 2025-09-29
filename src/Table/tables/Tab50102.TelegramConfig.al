table 50102 TelegramConfig
{
    Caption = 'TelegramConfig';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
            AutoIncrement = false;
        }
        field(2; url; Code[50])
        {
            Caption = 'url';
        }
        field(3; token; Code[100])
        {
            Caption = 'token';
        }
    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }
}
