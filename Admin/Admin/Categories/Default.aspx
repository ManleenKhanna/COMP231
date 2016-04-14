<%@ Page Title="Categories" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Admin.Categories.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminBody" runat="server">
    <div>
        <asp:UpdatePanel ID="UpdatePanelGridViewCategories" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridViewCategories" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="CategoryId" AllowPaging="true" ShowFooter="true"
                        OnPageIndexChanging="OnPaging" OnRowEditing="EditCategory"
                        OnRowUpdating="UpdateCategory" OnRowCancelingEdit="CancelEdit" PageSize="7" ShowHeaderWhenEmpty="true" CssClass="table table-bordered table-striped"
                        HeaderStyle-BackColor="#23527C" HeaderStyle-ForeColor="#FFFFFF">
                        <Columns>
                            <asp:TemplateField HeaderText="Category ID" Visible="false" HeaderStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_category_id" runat="server" Text='<%# Eval("CategoryId")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Category Name" HeaderStyle-CssClass="text-center col-md-8" ItemStyle-CssClass="col-md-8" FooterStyle-CssClass="col-md-8">
                                <ItemTemplate>
                                    <asp:Label ID="label_category_name" runat="server" Text='<%# Eval("CategoryName")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="text_edit_category_name" runat="server" Text='<%# Eval("CategoryName")%>' ToolTip="Category name" placeholder="Enter category name" ValidationGroup="editCategory" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditCategoryName" runat="server" ErrorMessage="* Required" ControlToValidate="text_edit_category_name" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="editCategory"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="text_add_category_name" runat="server" ToolTip="Category name" placeholder="Enter category name" ValidationGroup="addNewCategory" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorCategoryName" runat="server" ErrorMessage="* Required" ControlToValidate="text_add_category_name" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="addNewCategory"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderStyle-CssClass="text-center col-md-2" ItemStyle-CssClass="text-center col-md-2" FooterStyle-CssClass="text-center col-md-2">
                                 <HeaderTemplate>
                                    <asp:Label ID="label_deparment_header" runat="server" Text="Department"></asp:Label>
                                    <asp:DropDownList ID="dropDownList_header_department" runat="server" CssClass="btn-warning form-control"
                                    OnSelectedIndexChanged="departmentChanged" AutoPostBack="true"
                                    AppendDataBoundItems="true" DataSourceID="SqlDataSource_department" DataTextField="departmentName" DataValueField="departmentId"  ToolTip="Filter by department">
                                    <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                                </asp:DropDownList>
                                 </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="label_department_name" runat="server" Text='<%# Eval("departmentName")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="dropDownList_edit_department" runat="server" CssClass="form-control" DataSourceID="SqlDataSource_department" DataTextField="departmentName" DataValueField="departmentId"  ToolTip="Select department">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="dropDownList_add_department" runat="server" CssClass="form-control" DataSourceID="SqlDataSource_department" DataTextField="departmentName" DataValueField="departmentId"  ToolTip="Select department">
                                    </asp:DropDownList>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False" HeaderStyle-CssClass="text-center col-md-2 dropdown-in-table-header" ItemStyle-CssClass="text-center col-md-2 dropdown-in-table-header" FooterStyle-CssClass="text-center col-md-2 dropdown-in-table-header">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" CommandName="Edit" CausesValidation="False" ID="ButtonEdit" Width="24px" ImageUrl="~/svg/edit.svg" ToolTip="Edit"></asp:ImageButton>
                                    <asp:ImageButton runat="server" Text="Delete" CommandName="Delete" CausesValidation="False" ID="ButtonDelete" Width="24px" ImageUrl="~/svg/delete.svg"
                                        CommandArgument='<%# Eval("CategoryId")%>'
                                        OnClientClick="return confirm('Do you want to delete the category?')"
                                        OnClick="DeleteCategory" ToolTip="Delete"></asp:ImageButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ImageButton runat="server" Text="Update" CommandName="Update" CausesValidation="True" ID="ButtonUpdate" Width="24px" ImageUrl="~/svg/update.svg" ToolTip="Update" ValidationGroup="editCategory"></asp:ImageButton>
                                    <asp:ImageButton runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="False" ID="ButtonCancel" Width="24px" ImageUrl="~/svg/cancel.svg" ToolTip="Cancel"></asp:ImageButton>
                                </EditItemTemplate>
                                 <FooterTemplate>
                                    <asp:ImageButton runat="server" Text="Add" CommandName="Add" CausesValidation="True" ID="ButtonAdd" Width="24px" ImageUrl="~/svg/add.svg" OnClick="AddNewCategory" ToolTip="Add" ValidationGroup="addNewCategory"></asp:ImageButton>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource_department" runat="server" ConnectionString='<%$ ConnectionStrings:gameOnConnectionString %>' SelectCommand="SELECT [departmentId], [departmentName] FROM [Department]"></asp:SqlDataSource>
            </ContentTemplate> 
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID = "GridViewCategories" /> 
        </Triggers> 
        </asp:UpdatePanel>

    </div>
</asp:Content>

