Attribute VB_Name = "Module1"
Sub HW_Easy()
'Create a script that will loop through each year of stock data and grab the total amount of volume each stock had over the year.

'You will also need to display the ticker symbol to coincide with the total volume.

'-----------------------------------------------------------------------------------------------------------------
'set initial variable for holding a ticker type
Dim ticker As String

'set and inialize volume total

Dim vol_total As Double
vol_total = 0

'track location for ticker type
Dim type_table_row As Integer
type_table_row = 2

'For loop through ticker types
'First initialize last row and column
lastRow = Cells(Rows.Count, 1).End(xlUp).Row

For i = 2 To lastRow

'Check for same ticker or differene
    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
    
        'Set ticker name
        ticker = Cells(i, 1).Value
      
        'add to volume total
        vol_total = vol_total + Cells(i, 7).Value
    
        'Print ticker name to the summary table
        Range("J" & type_table_row).Value = ticker
    
        'Print volume total
    
        Range("K" & type_table_row).Value = vol_total
        
        'increase the ticker table by one
        type_table_row = type_table_row + 1
        
        'for different ticker type reset volume
        vol_total = 0
        
        Else
            'add to volume total id next ticker is same as current ticker
            vol_total = vol_total + Cells(i, 7).Value
            
    End If
   Next i
    
        Range("J1").Value = "<ticker>"
        Range("K1").Value = "<Volume Total>"

End Sub
Sub HW_Moderate()
'Create a script that will loop through all the stocks and take the following info.
'* Yearly change from what the stock opened the year at to what the closing price was.
'* The percent change from the what it opened the year at to what it closed.
' * The total Volume of the stock
'* Ticker symbol
'* You should also have conditional formatting that will highlight positive change in green and negative change in red.

'set initial variable for holding a ticker type
Dim ticker As String

Dim ticker_type As String
Dim Yr_Diff As String
Dim PerChange As String
Dim Volume As String


ticker_type = "<ticker>"
Range("J1").Value = ticker_type

Yr_Diff = "<yearly difference>"
Range("K1").Value = Yr_Diff

PerChange = "<percent change>"
Range("L1").Value = PerChange

Volume = "<volume total>"
Range("M1").Value = Volume

'set and inialize volume total

Dim vol_total As Double
vol_total = 0

'intialize open and close totals
Dim open_total As Double
Dim close_total As Double
Dim Perc_inc As Double

open_total = 0
close_total = 0
Perc_inc = 0

'track location for ticker type
Dim type_table_row As Integer
type_table_row = 2

'For loop through ticker types
'First initialize last row and column
lastRow = Cells(Rows.Count, 1).End(xlUp).Row

For i = 2 To lastRow

'Check for same ticker or differene
    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
    
        'Set ticker name
        ticker = Cells(i, 1).Value
        
        
        'add close total and open total
        open_total = open_total + Cells(i, 3).Value
        
        close_total = close_total + Cells(i, 6).Value
        
        'add to volume total
        vol_total = vol_total + Cells(i, 7).Value
    
        'Print ticker name to the summary table
        Range("J" & type_table_row).Value = ticker
        
        'Print yearly change difference
        
        Range("K" & type_table_row).Value = close_total - open_total
         
            'Fill cells based on yearly change
            If Range("K" & type_table_row).Value >= 0 Then
                Range("K" & type_table_row).Interior.ColorIndex = 4
                
            Else
                Range("K" & type_table_row).Interior.ColorIndex = 3
                
            End If
            
        'Print Percent change
        Range("L" & type_table_row).Value = ((close_total - open_total) / (open_total * 0.01))
      
        
         Range("L" & type_table_row).NumberFormat = "00.00%"
       
    
        
        
       
    
        'Print volume total
    
        Range("M" & type_table_row).Value = vol_total
        
    
        'increase the ticker table by one
        type_table_row = type_table_row + 1
        
        'for different ticker type reset volume
        vol_total = 0
        
        Else
            'add to volume total id next ticker is same as current ticker
            vol_total = vol_total + Cells(i, 7).Value
            
            close_total = close_total + Cells(i, 6).Value
            
            open_total = open_total + Cells(i, 3).Value
    End If
   Next i

End Sub
Sub HW_Hard()

'Your solution will include everything from the moderate challenge.
'Your solution will also be able to locate the stock with the "Greatest % increase", "Greatest % Decrease" and "Greatest total volume".

'set initial variable for holding a ticker type
Dim ticker As String

Dim ticker_type As String
Dim Yr_Diff As String
Dim PerChange As String
Dim Volume As String


ticker_type = "<ticker>"
Range("J1").Value = ticker_type

Yr_Diff = "<yearly difference>"
Range("K1").Value = Yr_Diff

PerChange = "<percent change>"
Range("L1").Value = PerChange

Volume = "<volume total>"
Range("M1").Value = Volume

'set and inialize volume total

Dim vol_total As Double
vol_total = 0

'intialize open and close totals
Dim open_total As Double
Dim close_total As Double
Dim Perc_inc As Double

open_total = 0
close_total = 0
Perc_inc = 0

'track location for ticker type
Dim type_table_row As Integer
type_table_row = 2

'For loop through ticker types
'First initialize last row and column
lastRow = Cells(Rows.Count, 1).End(xlUp).Row

For i = 2 To lastRow

'Check for same ticker or differene
    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
    
        'Set ticker name
        ticker = Cells(i, 1).Value
        
        
        'add close total and open total
        open_total = open_total + Cells(i, 3).Value
        
        close_total = close_total + Cells(i, 6).Value
        
        'add to volume total
        vol_total = vol_total + Cells(i, 7).Value
    
        'Print ticker name to the summary table
        Range("J" & type_table_row).Value = ticker
        
        'Print yearly change difference
        
        Range("K" & type_table_row).Value = close_total - open_total
         
            'Fill cells based on yearly change
            If Range("K" & type_table_row).Value >= 0 Then
                Range("K" & type_table_row).Interior.ColorIndex = 4
                
            Else
                Range("K" & type_table_row).Interior.ColorIndex = 3
                
            End If
            
        'Print Percent change
         Range("L" & type_table_row).Value = ((close_total - open_total) / (open_total * 0.01))
      
        
         Range("L" & type_table_row).NumberFormat = "00.00%"
       
    
    
        'Print volume total
    
        Range("M" & type_table_row).Value = vol_total
        
    
        'increase the ticker table by one
        type_table_row = type_table_row + 1
        
        'for different ticker type reset volume
        vol_total = 0
        
        Else
            'add to volume total id next ticker is same as current ticker
            vol_total = vol_total + Cells(i, 7).Value
            
            close_total = close_total + Cells(i, 6).Value
            
            open_total = open_total + Cells(i, 3).Value
    End If
    
   
   Next i
   'initialize lastrow search
    lastrow_2 = Cells(Rows.Count, 12).End(xlUp).Row
    
    Dim grt_per_inc As Double
    grt_per_inc = 0
    Dim max_ticker As String
    Dim grt_per_dec As Double
    Dim grt_vol As Double
    
    grt_per_dec = 0
    grt_vol = 0
    
    'Search for Greastest percent differences
    
    For i = 2 To lastrow_2
    
        If Cells(i, 12).Value > grt_per_inc Then
            grt_per_inc = Cells(i, 12).Value
            max_ticker = Cells(i, 10).Value
        
        End If
                
         
        Next i
    Range("P2").Value = "Greatest % increase"
    Range("R2").Value = grt_per_inc
    Range("R2").NumberFormat = "00.00%"
   
    Range("Q2").Value = max_ticker
    
    'search for greatest percent decrease
     For i = 2 To lastrow_2
    
        If Cells(i, 12).Value < grt_per_dec Then
            grt_per_dec = Cells(i, 12).Value
            max_ticker = Cells(i, 10).Value
        
        End If
                
         
        Next i
    Range("P4").Value = "Greatest % decrease"
    Range("R4").Value = grt_per_dec
    Range("R4").NumberFormat = "00.00%"
   
    Range("Q4").Value = max_ticker
    
    'search for greatest total volume
     For i = 2 To lastrow_2
    
        If Cells(i, 13).Value > grt_vol Then
            grt_vol = Cells(i, 13).Value
            max_ticker = Cells(i, 10).Value
        
        End If
                
          
        Next i
    Range("P6").Value = "Greatest Volume"
    Range("R6").Value = grt_vol
    
   
    Range("Q6").Value = max_ticker
End Sub
Sub HW_Challenge()

Dim ws As Worksheet

Application.ScreenUpdating = False
For Each ws In Worksheets
  ws.Select
  
    
    
    Call HW_Hard
    
    
Next

Application.ScreenUpdating = True

End Sub
Sub Clear()
Sheets("2016").Range("J:J, K:K, L:L, M:M, P:P, Q:Q, R:R").Clear
Sheets("2015").Range("J:J, K:K, L:L, M:M, P:P, Q:Q, R:R").Clear
Sheets("2014").Range("J:J, K:K, L:L, M:M, P:P, Q:Q, R:R").Clear

End Sub
Sub Combine_Data()
    ' Add a sheet named "Combined Data"
    Sheets.Add.Name = "Combined_Data"
    'move created sheet to be first sheet
    Sheets("Combined_Data").Move Before:=Sheets(1)
    ' Specify the location of the combined sheet
    Set combined_sheet = Worksheets("Combined_Data")

    ' Loop through all sheets
    For Each ws In Worksheets

        ' Find the last row of the combined sheet after each paste
        ' Add 1 to get first empty row
        lastRow = combined_sheet.Cells(Rows.Count, "A").End(xlUp).Row + 1

        ' Find the last row of each worksheet
        ' Subtract one to return the number of rows without header
        lastRowState = ws.Cells(Rows.Count, "A").End(xlUp).Row - 1

        ' Copy the contents of each state sheet into the combined sheet
        combined_sheet.Range("A" & lastRow & ":G" & ((lastRowState - 1) + lastRow)).Value = ws.Range("A2:G" & (lastRowState + 1)).Value

    Next ws

    ' Copy the headers from sheet 1
    combined_sheet.Range("A1:G1").Value = Sheets(2).Range("A1:G1").Value
    
    ' Autofit to display data
    combined_sheet.Columns("A:G").AutoFit
    
  
End Sub
