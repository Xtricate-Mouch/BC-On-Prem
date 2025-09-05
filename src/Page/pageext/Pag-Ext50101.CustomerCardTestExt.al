pageextension 50101 "Customer Card Test Ext" extends "Currencies"
{
    actions
    {
        addfirst(processing)
        {
            action(Testing)
            {
                Caption = 'Hello Testing';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ExchangeRate: Codeunit ExchangeRate;
                begin
                    ExchangeRate.ExchangeRate(Rec);
                end;
            }
        }
    }
}
