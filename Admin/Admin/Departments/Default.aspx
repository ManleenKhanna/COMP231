<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Admin.Departments.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminBody" runat="server">
    <div>
        <asp:UpdatePanel ID="UpdatePanelGridViewDepartments" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridViewDepartments" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="DepartmentId" AllowPaging="true" ShowFooter="true"
                        OnPageIndexChanging="OnPaging" OnRowEditing="EditDepartment"
                        OnRowUpdating="UpdateDepartment" OnRowCancelingEdit="CancelEdit" PageSize="7" ShowHeaderWhenEmpty="true" CssClass="table table-bordered table-striped"
                        HeaderStyle-BackColor="#23527C" HeaderStyle-ForeColor="#FFFFFF">
                        <Columns>
                            <asp:TemplateField HeaderText="Department ID" Visible="false" HeaderStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_department_id" runat="server" Text='<%# Eval("DepartmentId")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Department Name" HeaderStyle-CssClass="text-center col-md-10" ItemStyle-CssClass="col-md-10" FooterStyle-CssClass="col-md-10">
                                <ItemTemplate>
                                    <asp:Label ID="label_department_name" runat="server" Text='<%# Eval("DepartmentName")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="text_edit_department_name" runat="server" Text='<%# Eval("DepartmentName")%>' ToolTip="Department name" placeholder="Enter department name" ValidationGroup="editDepartment" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditDepartmentName" runat="server" ErrorMessage="* Required" ControlToValidate="text_edit_department_name" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="editDepartment"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="text_add_department_name" runat="server" ToolTip="Department name" placeholder="Enter department name" ValidationGroup="addNewDepartment" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorDepartmentName" runat="server" ErrorMessage="* Required" ControlToValidate="text_add_department_name" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="addNewDepartment"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False" HeaderStyle-CssClass="text-center col-md-2" ItemStyle-CssClass="text-center col-md-2" FooterStyle-CssClass="text-center col-md-2">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" CommandName="Edit" CausesValidation="False" ID="ButtonEdit" Width="24px" ImageUrl="~/svg/edit.svg" ToolTip="Edit"></asp:ImageButton>
                                    <asp:ImageButton runat="server" Text="Delete" CommandName="Delete" CausesValidation="False" ID="ButtonDelete" Width="24px" ImageUrl="~/svg/delete.svg"
                                        CommandArgument='<%# Eval("DepartmentId")%>'
                                        OnClientClick="return confirm('Do you want to delete the department?')"
                                        OnClick="DeleteDepartment" ToolTip="Delete"></asp:ImageButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ImageButton runat="server" Text="Update" CommandName="Update" CausesValidation="True" ID="ButtonUpdate" Width="24px" ImageUrl="~/svg/update.svg" ToolTip="Update" ValidationGroup="editDepartment"></asp:ImageButton>
                                    <asp:ImageButton runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="False" ID="ButtonCancel" Width="24px" ImageUrl="~/svg/cancel.svg" ToolTip="Cancel"></asp:ImageButton>
                                </EditItemTemplate>
                                 <FooterTemplate>
                                    <asp:ImageButton runat="server" Text="Add" CommandName="Add" CausesValidation="True" ID="ButtonAdd" Width="24px" ImageUrl="~/svg/add.svg" OnClick="AddNewDepartment" ToolTip="Add" ValidationGroup="addNewDepartment"></asp:ImageButton>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
            </ContentTemplate> 
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID = "GridViewDepartments" /> 
        </Triggers> 
        </asp:UpdatePanel>
    </div>
</asp:Content>
