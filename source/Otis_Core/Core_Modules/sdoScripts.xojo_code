#tag Module
Protected Module sdoScripts
	#tag Method, Flags = &h0
		Function CheckForTroubleCharacters(sValue as String) As Boolean
		  
		  
		  
		  dim TroubleCharacters() as String = Array( chr(34),chr(39) )
		  
		  For Each s1 as string In TroubleCharacters()
		    dim n1 as integer = 0
		    
		    n1 = sValue.InStr(s1)
		    If n1 <> 0 Then
		      Return True
		    End If
		    
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StripTroubleCharacters(sValue as String) As String
		  dim s2 as string = sValue
		  
		  dim TroubleCharacters() as string = Array( chr(34),chr(39) )
		  
		  For Each s1 as string In TroubleCharacters()
		    dim n1 as integer = 0
		    
		    
		    dim bFinish as Boolean
		    While Not bFinish
		      
		      n1 = s2.InStr(s1)
		      If n1 <> 0 Then
		        
		        s2 = Left(s2, n1 - 1) +Mid(s2, n1 + 1)
		        
		      Else
		        bFinish = True
		        Exit
		      End If
		      
		    Wend
		    
		    
		  Next
		  
		  If s2 <> sValue Then
		    MsgBox( "Unfortunatly we cannot handle the follwing characters and they have been stripped out: ' """)
		  End If
		  Return s2
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Untitled()
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
