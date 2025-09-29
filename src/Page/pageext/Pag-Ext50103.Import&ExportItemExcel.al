pageextension 50103 "Import Item Excel" extends "Item List"
{

    actions
    {
        addfirst(processing)
        {
            action("Import Excel")
            {
                Caption = 'Import Excel';
                Promoted = true;
                PromotedCategory = Process;
                Image = ImportExcel;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ImportItem: Codeunit "Import&Export Excel";
                begin
                    //code unit
                    ImportItem."Import Item Excel"();
                end;
            }
            action(export)
            {
                Caption = 'Export Excel';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Export;

                trigger OnAction()
                var
                    export: Codeunit "Import&Export Excel";
                begin
                    export."Export Item Excel"();
                end;
            }
            action(Filter)
            {
                Caption = 'Item Filter';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = UseFilters;

                trigger OnAction()
                var
                    ItemFilter: Record Item;
                begin
                    CurrPage.SetSelectionFilter(ItemFilter);
                    Message('Filter=%1, Count=%2', ItemFilter.GetFilters(), ItemFilter.Count);
                end;
            }


        }
    }
}