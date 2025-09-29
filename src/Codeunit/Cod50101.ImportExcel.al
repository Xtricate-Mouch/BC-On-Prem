codeunit 50101 "Import&Export Excel"
{
    procedure "Import Item Excel"()
    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        ItemExcel: Record "Item Buffer";
        InStr: InStream;
        FileName: Text;
        SheetName: Text;
        CurrentRow: Integer;
    begin
        // Ask user for file
        if UploadIntoStream('Import Excel', '', 'Excel File (*.xlsx)|*.xlsx', FileName, InStr) then begin
            // Select and read sheet
            SheetName := ExcelBuffer.SelectSheetsNameStream(InStr);
            ExcelBuffer.OpenBookStream(InStr, SheetName);
            ExcelBuffer.ReadSheet();

            // // Loop rows
            // ExcelBuffer.Reset();
            // if ExcelBuffer.FindSet() then begin
            //     CurrentRow := 0;
            //     repeat
            //         if ExcelBuffer."Row No." <> CurrentRow then begin
            //             if CurrentRow <> 0 then
            //                 ItemExcel.Insert(); // insert previous row

            //             ItemExcel.Init();
            //             CurrentRow := ExcelBuffer."Row No.";
            //         end;

            //         case ExcelBuffer."Column No." of
            //             1:
            //                 ItemExcel."No." := ExcelBuffer."Cell Value as Text";
            //             2:
            //                 ItemExcel.Description := ExcelBuffer."Cell Value as Text";
            //             3:
            //                 ItemExcel."Item Category Code" := ExcelBuffer."Cell Value as Text";
            //         end;
            //     until ExcelBuffer.Next() = 0;

            //     // Insert last row
            //     if CurrentRow <> 0 then
            //         ItemExcel.Insert();
            // end;

            Message('Imported %1 rows,%2 Column', ExcelBuffer."Row No.", ExcelBuffer."Column No.");
        end else
            Error('No file was uploaded.');
    end;


    procedure "Export Item Excel"()
    var
        ItemRec: Record Item;
        ExcelBuf: Record "Excel Buffer";
        FileName: Text;
    begin
        // Clear previous buffer data
        ExcelBuf.DeleteAll();

        // Add column headers
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(' Item Category Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


        // Add item rows
        if ItemRec.FindSet() then
            repeat
                ExcelBuf.NewRow();
                ExcelBuf.AddColumn(ItemRec."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(ItemRec.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(ItemRec."Item Category Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            until ItemRec.Next() = 0;

        // Create Excel file
        ExcelBuf.CreateNewBook('Item List');
        ExcelBuf.WriteSheet('Items', CompanyName, UserId);
        ExcelBuf.CloseBook();

        // Download Excel
        FileName := 'Item List.xlsx';
        ExcelBuf.SetFriendlyFilename(FileName); // Optional, sets the download name
        ExcelBuf.OpenExcel();
    end;

}
