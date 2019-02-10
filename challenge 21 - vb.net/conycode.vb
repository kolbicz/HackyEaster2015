Imports System.Text.RegularExpressions
Imports System.Text

Public Class Form1

    Private Sub Button1_Click(sender As System.Object, e As System.EventArgs) Handles Button1.Click

        Dim myBitmap As New Bitmap("conycode.bmp")
        Dim binary = ""

        For y = 1 To myBitmap.Height - 1 Step 17
            For x = 1 To myBitmap.Width - 1 Step 17
                Dim pixelColor As Color = myBitmap.GetPixel(x, y)
                Dim bits = 0
                If pixelColor.R = 255 Then
                    bits = bits Or Convert.ToInt32("100", 2)
                End If

                If pixelColor.G = 255 Then
                    bits = bits Or Convert.ToInt32("010", 2)
                End If

                If pixelColor.B = 255 Then
                    bits = bits Or Convert.ToInt32("001", 2)
                End If

                bits = (Not bits) And 7
                binary += Convert.ToString(bits, 2).PadLeft(3, "0")
            Next
        Next

        Dim BinaryText As String = binary
        Dim Characters As String = Regex.Replace(BinaryText, "[^01]", "")
        Dim ByteArray((Characters.Length / 8) - 1) As Byte
        For Index As Integer = 0 To ByteArray.Length - 1
            ByteArray(Index) = Convert.ToByte(Characters.Substring(Index * 8, 8), 2)
        Next
        TextBox1.Text = (ASCIIEncoding.ASCII.GetString(ByteArray))

    End Sub
End Class
