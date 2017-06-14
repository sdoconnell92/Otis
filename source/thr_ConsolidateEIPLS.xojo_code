#tag Class
Protected Class thr_ConsolidateEIPLS
Inherits Thread
	#tag Event
		Sub Run()
		  dim selectedRowTags() as mdRowTag
		  selectedRowTags() = MainWindow.ListBox_EIPL.getSelectedRowTags
		  
		  dim arsPKIDs() as string
		  For Each oRowTag as mdRowTag In selectedRowTags()
		    arsPKIDs.Append(oRowTag.pkid)
		  Next
		  dim sPKIDs as string
		  sPKIDs = Join(arsPKIDs, ",") 
		  
		  dim sql1 as string
		  sql1 = "Select * From consol_eipls('" + sPKIDs + "')"
		  Otis.db.SQLExecute(sql1)
		  
		  if Otis.db.error THen
		    break
		  end if
		  
		  MainWindow.ListBox_EIPL.loadMe
		  
		End Sub
	#tag EndEvent


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
