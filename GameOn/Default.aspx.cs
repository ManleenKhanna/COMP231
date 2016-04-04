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

namespace GameOn
{
    public partial class Default : System.Web.UI.Page
    {
        private string strConnString = ConfigurationManager.ConnectionStrings["FootworksDBConnectionString"].ConnectionString;
        DataTable dataTable;
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
            SqlCommand cmd = new SqlCommand("[sp_get_recently_added_products]", con);
            cmd.CommandType = CommandType.StoredProcedure;

            GetData(cmd);
            loadRecentlyAdded();
        }

        private void GetData(SqlCommand cmd)
        {
            dataTable = new DataTable();
            SqlConnection con = new SqlConnection(strConnString);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dataTable);
            //return dataTable;
        }

        private void loadRecentlyAdded()
        {
            //creating div
            HtmlGenericControl recentProductsDiv1 = new HtmlGenericControl("Div");
            HtmlGenericControl recentProductsDiv2 = new HtmlGenericControl("Div");

            for (int i = 0; i < dataTable.Rows.Count; i++)
            {
                HtmlGenericControl productDiv = new HtmlGenericControl("Div");
                productDiv.Attributes.Add("Class", "col-md-4 custom-center");

                ImageButton imageButton = new ImageButton();
                imageButton.ImageUrl = "~/" + dataTable.Rows[i][5].ToString();
                imageButton.PostBackUrl = "~/Product.aspx?productID=" + dataTable.Rows[i][0].ToString();
                imageButton.Width = 250;
                imageButton.Height = 260;
                imageButton.CssClass = "grid_img cust_img"; // product image css

                Button button = new Button();
                button.PostBackUrl = "~/Product.aspx?productID=" + dataTable.Rows[i][0].ToString();
                button.Text = dataTable.Rows[i][1].ToString();
                button.CssClass = "h4 m_1"; // product name css

                //creating individual div for controls
                HtmlGenericControl imageButtonDiv = new HtmlGenericControl("Div");
                imageButtonDiv.Controls.Add(imageButton);

                HtmlGenericControl buttonDiv = new HtmlGenericControl("Div");
                buttonDiv.Controls.Add(button);


                productDiv.Controls.Add(imageButtonDiv);
                productDiv.Controls.Add(buttonDiv);

                if (i < 3)
                {
                    recentProductsDiv1.Controls.Add(productDiv);
                }
                else
                {
                    recentProductsDiv2.Controls.Add(productDiv);
                }
            }

            mainContent.Controls.Add(recentProductsDiv1);
            mainContent.Controls.Add(recentProductsDiv2);
        }
    }
}