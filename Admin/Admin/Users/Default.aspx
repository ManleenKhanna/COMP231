<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Admin.Users.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminBody" runat="server">
    <div>
        <asp:UpdatePanel ID="UpdatePanelGridViewUsers" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridViewUsers" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="userid" AllowPaging="true" ShowFooter="true"
                        OnPageIndexChanging="OnPaging" OnRowEditing="EditCustomer"
                        OnRowUpdating="UpdateCustomer" OnRowCancelingEdit="CancelEdit" PageSize="7" ShowHeaderWhenEmpty="true" CssClass="table table-bordered table-striped"
                        HeaderStyle-BackColor="#23527C" HeaderStyle-ForeColor="#FFFFFF">
                        <Columns>
                            <asp:TemplateField HeaderText="User ID" HeaderStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_user_id" runat="server" Text='<%# Eval("userid")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="text_edit_user_user_id" runat="server" Text='<%# Eval("userid")%>' ToolTip="User id" placeholder="Enter user id" ValidationGroup="editUser" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditUserid" runat="server" ErrorMessage="* Required" ControlToValidate="text_edit_user_user_id" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="editUser"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="text_add_user_user_id" runat="server" ToolTip="User id" placeholder="Enter user id" ValidationGroup="addNewUser" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorUserid" runat="server" ErrorMessage="* Required" ControlToValidate="text_add_user_user_id" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="addNewUser"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Username" HeaderStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_user_username" runat="server" Text='<%# Eval("username")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="text_edit_user_username" runat="server" Text='<%# Eval("username")%>' ToolTip="Username" placeholder="Enter username" ValidationGroup="editUser" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditUsername" runat="server" ErrorMessage="* Required" ControlToValidate="text_edit_user_username" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="editUser"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="text_add_user_username" runat="server" ToolTip="Username" placeholder="Enter username" ValidationGroup="addNewUser" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorUsername" runat="server" ErrorMessage="* Required" ControlToValidate="text_add_user_username" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="addNewUser"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Password" HeaderStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_user_password" runat="server" Text='<%# Eval("userpassword")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="text_edit_user_password" runat="server" Text='<%# Eval("userpassword")%>' ToolTip="Password" placeholder="Enter password" ValidationGroup="editUser" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditPassword" runat="server" ErrorMessage="* Required" ControlToValidate="text_edit_user_password" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="editUser"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="text_add_user_password" runat="server" ToolTip="Password" placeholder="Enter password" ValidationGroup="addNewUser" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server" ErrorMessage="* Required" ControlToValidate="text_add_user_password" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="addNewUser"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Email" HeaderStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_user_email" runat="server" Text='<%# Eval("useremail")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="text_edit_user_email" runat="server" Text='<%# Eval("useremail")%>' ToolTip="Email" placeholder="Enter email" ValidationGroup="editUser" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditEmail" runat="server" ErrorMessage="* Required" ControlToValidate="text_edit_user_email" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="editUser"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="text_add_user_email" runat="server" ToolTip="Email" placeholder="Enter email" ValidationGroup="addNewUser" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ErrorMessage="* Required" ControlToValidate="text_add_user_email" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="addNewUser"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Phone" HeaderStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_user_phone" runat="server" Text='<%# Eval("userphone")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="text_edit_user_phone" runat="server" Text='<%# Eval("userphone")%>' ToolTip="Phone" placeholder="Enter phone" ValidationGroup="editUser" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditPhone" runat="server" ErrorMessage="* Required" ControlToValidate="text_edit_user_phone" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="editUser"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="text_add_user_phone" runat="server" ToolTip="Phone" placeholder="Enter phone" ValidationGroup="addNewUser" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPhone" runat="server" ErrorMessage="* Required" ControlToValidate="text_add_user_phone" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="addNewUser"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" CommandName="Edit" CausesValidation="False" ID="ButtonEdit" Width="24px" ImageUrl="~/svg/edit.svg" ToolTip="Edit"></asp:ImageButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ImageButton runat="server" Text="Update" CommandName="Update" CausesValidation="True" ID="ButtonUpdate" Width="24px" ImageUrl="~/svg/update.svg" ToolTip="Update" ValidationGroup="editUser"></asp:ImageButton>
                                    <asp:ImageButton runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="False" ID="ButtonCancel" Width="24px" ImageUrl="~/svg/cancel.svg" ToolTip="Cancel"></asp:ImageButton>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" Text="Delete" CommandName="Delete" CausesValidation="False" ID="ButtonDelete" Width="24px" ImageUrl="~/svg/delete.svg"
                                        CommandArgument='<%# Eval("userid")%>'
                                        OnClientClick="return confirm('Do you want to delete the user?')"
                                        OnClick="DeleteCustomer" ToolTip="Delete"></asp:ImageButton>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:ImageButton runat="server" Text="Add" CommandName="Add" CausesValidation="True" ID="ButtonAdd" Width="24px" ImageUrl="~/svg/add.svg" OnClick="AddNewCustomer" ToolTip="Add" ValidationGroup="addNewUser"></asp:ImageButton>
                                </FooterTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
            </ContentTemplate> 
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID = "GridViewUsers" /> 
        </Triggers> 
        </asp:UpdatePanel>
    </div>
</asp:Content>
