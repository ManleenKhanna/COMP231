<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Footworks.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Slider" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Products" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanelGridViewUsers" runat="server" class="container-fluid" style="padding-top: 20px">
                <ContentTemplate>
                    <asp:GridView ID="GridViewUsers" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="cartid" AllowPaging="true" ShowFooter="true"
                        OnPageIndexChanging="OnPaging" PageSize="7" ShowHeaderWhenEmpty="true" CssClass="table table-bordered table-striped"
                        HeaderStyle-BackColor="#23527C" HeaderStyle-ForeColor="#FFFFFF">
                        <Columns>
                            <asp:TemplateField HeaderText="Cart ID" Visible="false" HeaderStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_cart_id" runat="server" Text='<%# Eval("cartid")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Product ID" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_product_id" runat="server" Text='<%# Eval("productid")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Product Name" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_product_name" runat="server" Text='<%# Eval("productname")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Product Image" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Image ID="Image_product_image" runat="server" ImageUrl='<%# string.Concat("~/",Eval("productthumbnail"))%>' Width="64" Height="64" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Unit Price" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_unit_price" runat="server" Text='<%# string.Concat("$ ",Eval("cartunitcost"))%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Quantity" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_quantity" runat="server" Text='<%# Eval("cartquantity")%>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="label_quantity" runat="server" Text="Total:"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Total Price" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="label_total_price" runat="server" Text= '<%# string.Concat("$ ",Eval("totalPrice"))%>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="LabelTotal" runat="server" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" Text="Delete" CommandName="Delete" CausesValidation="False" ID="ButtonDelete" Width="24px" ImageUrl="~/svg/delete.svg"
                                        CommandArgument='<%# Eval("cartid")%>'
                                        OnClientClick="return confirm('Do you want to delete the product from the cart?')"
                                        OnClick="DeleteCustomer" ToolTip="Delete"></asp:ImageButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                    
                    <div style="clear:both"></div>
                    <div class="bhenchod_kutte bhencho" style="float: right; margin: 0px 0px 20px;">
                        <asp:Button ID="ButtonCheckOut" runat="server" Text="Checkout" OnClick="ButtonCheckout_Click" CssClass="btn btn-info"/>

                    </div>
                    
                    
            </ContentTemplate> 
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID = "GridViewUsers" /> 
            <asp:PostBackTrigger ControlID="ButtonCheckOut" />
        </Triggers> 
        </asp:UpdatePanel>
    </div>
</asp:Content>
