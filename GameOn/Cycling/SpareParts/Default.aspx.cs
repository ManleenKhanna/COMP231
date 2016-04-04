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

namespace GameOn.Cycling.SpareParts
{
    public partial class Default : System.Web.UI.Page
    {
        private string strConnString = ConfigurationManager.ConnectionStrings["FootworksDBConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("[sp_get_all_sub_categories_by_category_id]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@category_id", SqlDbType.Int).Value = 3;

            DataTable categories = GetData(cmd);

            loadCategories(categories);
        }

        private DataTable GetData(SqlCommand cmd)
        {
            DataTable dataTable = new DataTable();
            SqlConnection con = new SqlConnection(strConnString);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.Connection = con;
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dataTable);
            return dataTable;
        }

        private void loadCategories(DataTable categories)
        {
            for (int i = 0; i < categories.Rows.Count; i++)
            {
                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand("[sp_get_top_three_products_by_sub_category_id]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@sub_category_id", SqlDbType.NVarChar).Value = categories.Rows[i][0].ToString();

                DataTable products = GetData(cmd);
                if (products.Rows.Count > 0)
                {
                    HtmlGenericControl categoriesDiv = new HtmlGenericControl("Div");
                    categoriesDiv.Attributes.Add("Class", "panel-heading");

                    HyperLink categoriesName = new HyperLink();
                    categoriesName.Text = categories.Rows[i][1].ToString();
                    categoriesName.NavigateUrl = "~/Cycling/" + categories.Rows[i][1].ToString().Replace(" ", "");
                    categoriesName.Attributes.Add("Class", "panel-link");
                    categoriesDiv.Controls.Add(categoriesName);
                    mainContent.Controls.Add(categoriesDiv);
                    loadProducts(products);
                }

            }
        }

        private void loadProducts(DataTable products)
        {
            //creating div

            HtmlGenericControl subCategoriesDiv = new HtmlGenericControl("Div");
            subCategoriesDiv.Attributes.Add("Class", "container-flued panel-body");

            for (int i = 0; i < products.Rows.Count; i++)
            {
                HtmlGenericControl recentProductsDiv = new HtmlGenericControl("Div");
                recentProductsDiv.Attributes.Add("Class", "col-md-4 custom-center");

                ImageButton imageButton = new ImageButton();
                imageButton.ImageUrl = "~/" + products.Rows[i][5].ToString();
                imageButton.PostBackUrl = "~/Product.aspx?productID=" + products.Rows[i][0].ToString();
                imageButton.Width = 250;
                imageButton.Height = 260;
                imageButton.Attributes.Add("Class", "grid_img cust_img");

                Button button = new Button();
                button.PostBackUrl = "~/Product.aspx?productID=" + products.Rows[i][0].ToString();
                button.Text = products.Rows[i][1].ToString();
                button.Attributes.Add("Class", "h4 m_1");

                //creating individual div for controls
                HtmlGenericControl imageButtonDiv = new HtmlGenericControl("Div");
                imageButtonDiv.Controls.Add(imageButton);

                HtmlGenericControl buttonDiv = new HtmlGenericControl("Div");
                buttonDiv.Controls.Add(button);

                recentProductsDiv.Controls.Add(imageButtonDiv);
                recentProductsDiv.Controls.Add(buttonDiv);

                subCategoriesDiv.Controls.Add(recentProductsDiv);
            }



            mainContent.Controls.Add(subCategoriesDiv);
        }
    }
}