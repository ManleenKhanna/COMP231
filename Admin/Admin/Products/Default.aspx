<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Admin.Products.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminBody" runat="server">
    <div>
        <asp:UpdatePanel ID="UpdatePanelProduct" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridViewProduct" runat="server" AutoGenerateColumns="False" DataKeyNames="productid" AllowPaging="true"
                OnPageIndexChanging="OnPaging" OnRowEditing="GridViewProduct_RowEditing" PageSize="7" ShowHeaderWhenEmpty="true" CssClass="table table-bordered table-striped"
                HeaderStyle-BackColor="#23527C" HeaderStyle-ForeColor="#FFFFFF">
                <Columns>
                    <asp:TemplateField HeaderText="Product ID" Visible="false" HeaderStyle-CssClass="text-center">
                        <ItemTemplate>
                            <asp:Label ID="label_product_id" runat="server"
                                Text='<%# Eval("productID")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Product Name" HeaderStyle-CssClass="text-center">
                        <ItemTemplate>
                            <asp:Label ID="label_product_name" runat="server"
                                Text='<%# Eval("productName")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Product Description" HeaderStyle-CssClass="text-center">
                        <ItemTemplate>
                            <asp:Label ID="label_product_description" runat="server"
                                Text='<%# Eval("productDescription")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Product Price" HeaderStyle-CssClass="text-center">
                        <ItemTemplate>
                            <asp:Label ID="label_product_price" runat="server"
                                Text='<%# Eval("productPrice")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Product Thumbnail" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center">
                        <ItemTemplate>
                            <asp:Image ID="label_product_thumbnail" runat="server"
                                ImageUrl='<%# "http://www.admin.natiaa.com/Uploads/Testimonials/"+Eval("testimonial_picture") %>' Width="64px" Height="64px"></asp:Image>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText = "Testimonial Content" HeaderStyle-CssClass="text-center">
                    <ItemTemplate>
                        <asp:Label ID="lblTestimonialContent" runat="server"
                        Text='<%# Eval("testimonial_content")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False" ItemStyle-CssClass="text-center">
                             <ItemTemplate>
                                 <asp:ImageButton runat="server" CommandName="Edit" CausesValidation="False" ID="ButtonEdit" Width="24px" ImageUrl="~/svg/edit.svg" ToolTip="Edit"></asp:ImageButton>
                             </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False" ItemStyle-CssClass="text-center">
                             <ItemTemplate>
                                 <asp:ImageButton runat="server" Text="Delete" CommandName="Delete" CausesValidation="False" ID="ButtonDelete" Width="24px" ImageUrl="~/svg/delete.svg"
                                     CommandArgument = '<%# Eval("testimonial_id")%>' 
                                     OnClientClick = "return confirm('Do you want to delete?')"
                                     OnClick="ButtonDelete_Click" ToolTip="Delete">
                                 </asp:ImageButton>
                             </ItemTemplate>
                         </asp:TemplateField>
                </Columns>
        </asp:GridView>
            </ContentTemplate> 
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID = "GridView1" /> 
    </Triggers> 
    </asp:UpdatePanel>
    </div>
</asp:Content>
