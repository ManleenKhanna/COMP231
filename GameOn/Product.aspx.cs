using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Collections;
using System.IO.Compression;
using System.IO;

namespace Footworks
{
    public partial class Product : System.Web.UI.Page
    {
        private string strConnString = ConfigurationManager.ConnectionStrings["FootworksDBConnectionString"].ConnectionString;
        private int stockID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
                validateStock();
            }
        }

        private void BindData()
        {

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_get_product_details_by_id", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@product_id", SqlDbType.Int).Value = Request.QueryString["productID"];
            DataTable product = GetData(cmd);
            if (product.Rows.Count > 0)
            {
                loadData(product);
            }
            else
            {
                //TODO redirect to error page
            }
        }

        private DataTable GetData(SqlCommand cmd)
        {
            DataTable dataTable = new DataTable();
            SqlConnection con = new SqlConnection(strConnString);
            SqlDataAdapter sda = new SqlDataAdapter();

            try
            {
                cmd.Connection = con;
                con.Open();
                sda.SelectCommand = cmd;
                sda.Fill(dataTable);
            }
            catch (Exception ex)
            {
                //TODO redirect to error page
            }
            return dataTable;
        }

        private void loadData(DataTable dataTable)
        {
            LabelProductName.Text = dataTable.Rows[0][1].ToString();
            LabelProductPrice.Text = (Convert.ToInt32(dataTable.Rows[0][3])).ToString("C2");
            ImageProductDisplay.ImageUrl = "~/"+dataTable.Rows[0][5].ToString();

            //Load Description
            TextReader read = new System.IO.StringReader(dataTable.Rows[0][2].ToString());
            int rows = 60;

            string[] text1 = new string[rows];

            for (int r = 0; r < rows; r++)
            {

                text1[r] = read.ReadLine();

                string line = text1[r];
                if (line != null)
                {

                    TableRow rowNew = new TableRow();
                    TableProductDescription.Controls.Add(rowNew);
                    TableCell CellNewHeader = new TableCell();

                    TableCell CellNewColon = new TableCell();

                    TableCell CellNewDescription = new TableCell();

                    // do your coding 
                    //Loop trough txt file and add lines to ListBox1  
                    Label LabelHeader = new Label();

                    Label LabelDescription = new Label();

                    Label LabelColon = new Label();

                    int index = line.IndexOf(":");
                    if (index != -1)
                    {
                        String text = "<b>" + line.Substring(0, index) + "</b>";
                        String text2 = line.Substring(index + 1);

                        LabelHeader.Text = text;
                        LabelColon.Text = ":";
                        LabelDescription.Text = text2;

                        //TextBox1.Text = line + "\n";

                        CellNewHeader.Controls.Add(LabelHeader);
                        CellNewColon.Controls.Add(LabelColon);
                        CellNewDescription.Controls.Add(LabelDescription);

                        rowNew.Controls.Add(CellNewHeader);
                        rowNew.Controls.Add(CellNewColon);
                        rowNew.Controls.Add(CellNewDescription);
                    }
                }
            }

            loadColours();
            loadSizes();
        }

        private void loadColours()
        {
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_get_colours_by_product_id", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@product_id", SqlDbType.Int).Value = Request.QueryString["productID"];
            DataTable colours = GetData(cmd);
            if (colours.Rows.Count > 0)
            {
                DropDownListColours.DataSource = colours;
                DropDownListColours.DataTextField = "ColorName";
                DropDownListColours.DataValueField = "ColorID";
                DropDownListColours.DataBind();
            }
            else
            {
                //TODO redirect to error page
            }
        }

        private void loadSizes()
        {
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_get_sizes_by_product_id", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@product_id", SqlDbType.Int).Value = Request.QueryString["productID"];
            DataTable sizes = GetData(cmd);
            if (sizes.Rows.Count > 0)
            {
                DropDownListSizes.DataSource = sizes;
                DropDownListSizes.DataTextField = "SizeName";
                DropDownListSizes.DataValueField = "SizeID";
                DropDownListSizes.DataBind();
            }
            else
            {
                //TODO redirect to error page
            }
        }

        protected void TextBoxQuantity_TextChanged(object sender, EventArgs e)
        {
            if (TextBoxQuantity.Text.Trim().Length == 0 || TextBoxQuantity.Text == "0")
            {
                TextBoxQuantity.Text = "1";
            }
            validateStock();
        }

        protected void DropDownListColours_SelectedIndexChanged(object sender, EventArgs e)
        {
            validateStock();
        }

        private void validateStock()
        {
            int colorIndex = Convert.ToInt32(DropDownListColours.SelectedValue);
            int sizeIndex = Convert.ToInt32(DropDownListSizes.SelectedValue);
            int quantity = Convert.ToInt32(TextBoxQuantity.Text);

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_get_stock_by_product_id_color_id_size_id", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@product_id", SqlDbType.Int).Value = Request.QueryString["productID"];
            cmd.Parameters.Add("@color_id", SqlDbType.Int).Value = colorIndex;
            cmd.Parameters.Add("@size_id", SqlDbType.Int).Value = sizeIndex;

            DataTable stock = GetData(cmd);
            if (stock.Rows.Count > 0)
            {
                if (Convert.ToInt32(stock.Rows[0][4].ToString()) > quantity)
                {
                    ButtonSubmit.Enabled = true;
                    LabelError.Text = "";
                    stockID = Convert.ToInt32(stock.Rows[0][0].ToString());
                }
                else
                {
                    ButtonSubmit.Enabled = false;
                    ButtonSubmit.CssClass = "aspNetDisabled btn_1";
                    if (quantity == 1)
                    {
                        LabelError.Text = "<div class='alert alert-danger' role='alert'><strong>Out of stock!</strong> Please try different size or color.</div>";
                    }
                    else
                    {
                        LabelError.Text = "<div class='alert alert-danger' role='alert'><strong>Out of stock!</stock> Please try different size or color, or try lesser quantity</div>";
                    }
                }
            }
            else
            {
                //TODO redirect to error page
            }
        }

        protected void DropDownListSizes_SelectedIndexChanged(object sender, EventArgs e)
        {
            validateStock();
        }

        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            validateStock();
            bool val1 = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;

            if (!val1)
            {
                FormsAuthentication.RedirectToLoginPage();
            }

            else
            {
                int quantity = Convert.ToInt32(TextBoxQuantity.Text);
                float unitPrice = float.Parse(LabelProductPrice.Text.Replace("$", ""));
                string userID = HttpContext.Current.User.Identity.Name;

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand("sp_insert_into_cart", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@stock_id", SqlDbType.Int).Value = stockID;
                cmd.Parameters.Add("@quantity", SqlDbType.Int).Value = quantity;
                cmd.Parameters.Add("@unitCost", SqlDbType.Float).Value = unitPrice;
                cmd.Parameters.Add("@userID", SqlDbType.VarChar).Value = userID;

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("~/cart.aspx");
                }
                catch (Exception exception)
                {
                    //TODO Redirect to error page
                }
                finally
                {
                    con.Close();
                }
            }
        }
    }
}