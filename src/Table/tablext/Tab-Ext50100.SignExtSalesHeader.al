tableextension 50100 "Sign Ext Sales Header" extends "Sales Header"
{
    fields
    {
        field(50100; "SGN Signature"; Blob)
        {
            Caption = 'Customer Signature';
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
    }

    procedure SignDocument(var Base64Text: Text)
    var
        Base64Cu: Codeunit "Base64 Convert";
        RecordRef: RecordRef;
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        ImageBase64String: Text;
    begin
        Base64Text := Base64Text.Replace('data:image/png;base64,', '');
        TempBlob.CreateOutStream(OutStream);
        Base64Cu.FromBase64(Base64Text, OutStream);
        RecordRef.GetTable(Rec);
        TempBlob.ToRecordRef(RecordRef, Rec.FieldNo("SGN Signature"));
        RecordRef.Modify();
    end;
}
