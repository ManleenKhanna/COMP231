<%@ Page Title="Sub Categories" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Admin.SubCategories.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminBody" runat="server">
    <div>
        <asp:UpdatePanel ID="UpdatePanelGridViewSubCategories" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridViewSubCategories" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="SubCategoryId" AllowPaging="true" ShowFooter="true"
                        OnPageIndexChanging="OnPaging" OnRowEditing="EditSubCategory"
                        OnRowUpdating="UpdateSubCategory" OnRowCancelingEdit="CancelEdit" PageSize="7" ShowHeaderWhenEmpty="true" CssClass="table table-bordered table-striped"
                        HeaderStyle-BackColor="#23527C" HeaderStyle-ForeColor="#FFFFFF">
                        <Columns>
                            <asp:TemplateField HeaderText="SubCategory ID" Visible="false" HeaderStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_sub_category_id" runat="server" Text='<%# Eval("SubCategoryId")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Sub-Category Name" HeaderStyle-CssClass="text-center col-md-8" ItemStyle-CssClass="col-md-8" FooterStyle-CssClass="col-md-8">
                                <ItemTemplate>
                                    <asp:Label ID="label_sub_category_name" runat="server" Text='<%# Eval("SubCategoryName")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="text_edit_sub_category_name" runat="server" Text='<%# Eval("SubCategoryName")%>' ToolTip="Sub-category name" placeholder="Enter sub-category name" ValidationGroup="editSubCategory" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditSubCategoryName" runat="server" ErrorMessage="* Required" ControlToValidate="text_edit_sub_category_name" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="editSubCategory"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="text_add_sub_category_name" runat="server" ToolTip="Sub-category name" placeholder="Enter sub-category name" ValidationGroup="addNewSubCategory" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorSubCategoryName" runat="server" ErrorMessage="* Required" ControlToValidate="text_add_sub_category_name" 
                                    Text="* Required" SetFocusOnError="True" CssClass="alert custom-alert alert-danger form-control" ValidationGroup="addNewSubCategory"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderStyle-CssClass="text-center col-md-2" ItemStyle-CssClass="text-center col-md-2" FooterStyle-CssClass="text-center col-md-2">
                                 <HeaderTemplate>
                                    <asp:Label ID="label_category_header" runat="server" Text="Category"></asp:Label>
                                    <asp:DropDownList ID="dropDownList_header_category" runat="server" CssClass="btn-warning form-control"
                                    OnSelectedIndexChanged="categoryChanged" AutoPostBack="true"
                                    AppendDataBoundItems="true" DataSourceID="SqlDataSource_category" DataTextField="categoryName" DataValueField="categoryId"  ToolTip="Filter by category">
                                    <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                                </asp:DropDownList>
                                 </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="label_category_name" runat="server" Text='<%# Eval("categoryName")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="dropDownList_edit_category" runat="server" CssClass="form-control" DataSourceID="SqlDataSource_category" DataTextField="categoryName" DataValueField="categoryId"  ToolTip="Select category">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="dropDownList_add_category" runat="server" CssClass="form-control" DataSourceID="SqlDataSource_category" DataTextField="categoryName" DataValueField="categoryId"  ToolTip="Select category">
                                    </asp:DropDownList>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False" HeaderStyle-CssClass="text-center col-md-2 dropdown-in-table-header" ItemStyle-CssClass="text-center col-md-2 dropdown-in-table-header" FooterStyle-CssClass="text-center col-md-2 dropdown-in-table-header">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" CommandName="Edit" CausesValidation="False" ID="ButtonEdit" Width="24px" ImageUrl="~/svg/edit.svg" ToolTip="Edit"></asp:ImageButton>
                                    <asp:ImageButton runat="server" Text="Delete" CommandName="Delete" CausesValidation="False" ID="ButtonDelete" Width="24px" ImageUrl="~/svg/delete.svg"
                                        CommandArgument='<%# Eval("SubCategoryId")%>'
                                        OnClientClick="return confirm('Do you want to delete the sub-category?')"
                                        OnClick="DeleteSubCategory" ToolTip="Delete"></asp:ImageButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ImageButton runat="server" Text="Update" CommandName="Update" CausesValidation="True" ID="ButtonUpdate" Width="24px" ImageUrl="~/svg/update.svg" ToolTip="Update" ValidationGroup="editSubCategory"></asp:ImageButton>
                                    <asp:ImageButton runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="False" ID="ButtonCancel" Width="24px" ImageUrl="~/svg/cancel.svg" ToolTip="Cancel"></asp:ImageButton>
                                </EditItemTemplate>
                                 <FooterTemplate>
                                    <asp:ImageButton runat="server" Text="Add" CommandName="Add" CausesValidation="True" ID="ButtonAdd" Width="24px" ImageUrl="~/svg/add.svg" OnClick="AddNewSubCategory" ToolTip="Add" ValidationGroup="addNewSubCategory"></asp:ImageButton>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource_category" runat="server" ConnectionString='<%$ ConnectionStrings:gameOnConnectionString %>' SelectCommand="SELECT [categoryId], [categoryName] FROM [Category]"></asp:SqlDataSource>
            </ContentTemplate> 
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID = "GridViewSubCategories" /> 
        </Triggers> 
        </asp:UpdatePanel>

    </div>
</asp:Content>

