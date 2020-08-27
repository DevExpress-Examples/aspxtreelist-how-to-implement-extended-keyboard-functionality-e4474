<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>

	<script type="text/javascript">
		function OnInit(s, e) {
			ASPxClientUtils.AttachEventToElement(
		s.GetMainElement(),
		"keydown",
		function (evt) {
			switch (evt.keyCode) {
				//F2               
				case 113:
					var key = s.GetFocusedNodeKey();
					s.StartEdit(key);
					break;


					//Delete           
				case 46:
					var key = s.GetFocusedNodeKey();
					s.DeleteNode(key);
					break;

					//F3          
				case 114:
					var key = s.GetFocusedNodeKey();
					s.StartEditNewNode(key);
					break;

					//ENTER              
				case 13:
					if (s.IsEditing()) {
						s.UpdateEdit();
					}
					break;

					//ESC               
				case 27:
					if (s.IsEditing()) {
						s.CancelEdit();
					}
					break;
			}
		}
	);
		}
	</script>

</head>
<body>
	<form id="form1" runat="server">

		<div>
			<ul>
				<li>
					<b>F2</b> - Edit the selected node;</li>
				<li>
					<b>F3</b> - Insert a new node;</li>
				<li>
					<b>Delete</b> - Delete the selected node;</li>
				<li>
					<b>Enter</b> - Close Edit Form and save changes;</li>
				<li>
					<b>Esc</b> - Close Edit Form without saving.</li>
			</ul>
			<dx:ASPxTreeList ID="treeList" runat="server" AutoGenerateColumns="False" DataSourceID="ads"
				KeyFieldName="CategoryID" KeyboardSupport="true" AccessKey="T">
				<SettingsBehavior AllowFocusedNode="true" />
				<ClientSideEvents Init="OnInit" />
				<Columns>
					<dx:TreeListTextColumn FieldName="CategoryName" VisibleIndex="0">
					</dx:TreeListTextColumn>
					<dx:TreeListTextColumn FieldName="Description" VisibleIndex="1">
					</dx:TreeListTextColumn>
				</Columns>
			</dx:ASPxTreeList>
			<asp:AccessDataSource ID="ads" runat="server" DataFile="~/App_Data/nwind.mdb" SelectCommand="SELECT [CategoryID], [CategoryName], [Description] FROM [Categories]"
				DeleteCommand="DELETE FROM [Categories] WHERE [CategoryID] = ?" InsertCommand="INSERT INTO [Categories] ([CategoryName], [Description]) VALUES (?, ?)"
				UpdateCommand="UPDATE [Categories] SET [CategoryName] = ?, [Description] = ? WHERE [CategoryID] = ?" OnDeleting="AccessDataSource1_Modifying" OnInserting="AccessDataSource1_Modifying" OnUpdating="AccessDataSource1_Modifying">
				<DeleteParameters>
					<asp:Parameter Name="CategoryID" Type="Int32" />
				</DeleteParameters>
				<UpdateParameters>
					<asp:Parameter Name="CategoryName" Type="String" />
					<asp:Parameter Name="Description" Type="String" />
					<asp:Parameter Name="CategoryID" Type="Int32" />
				</UpdateParameters>
				<InsertParameters>
					<asp:Parameter Name="CategoryName" Type="String" />
					<asp:Parameter Name="Description" Type="String" />
				</InsertParameters>
			</asp:AccessDataSource>
		</div>
	</form>
</body>
</html>