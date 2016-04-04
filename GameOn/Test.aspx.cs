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
    public partial class Test : System.Web.UI.Page
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
                ImageButton imageButton = new ImageButton();
                imageButton.ImageUrl = "~/"+dataTable.Rows[i][5].ToString();
                imageButton.PostBackUrl = "~/Product.aspx?productID=" + dataTable.Rows[i][0].ToString();
                imageButton.Width=100;

                Button button = new Button();
                button.PostBackUrl = "~/Product.aspx?productID=" + dataTable.Rows[i][0].ToString();
                button.Text = dataTable.Rows[i][1].ToString();

                //creating individual div for controls
                HtmlGenericControl imageButtonDiv = new HtmlGenericControl("Div");
                imageButtonDiv.Controls.Add(imageButton);

                HtmlGenericControl buttonDiv = new HtmlGenericControl("Div");
                buttonDiv.Controls.Add(button);

                
                if(i<3)
                {
                    recentProductsDiv1.Controls.Add(imageButtonDiv);
                    recentProductsDiv1.Controls.Add(buttonDiv);
                }
                else
                {
                    recentProductsDiv2.Controls.Add(imageButtonDiv);
                    recentProductsDiv2.Controls.Add(buttonDiv);
                }
            }

            mainContent.Controls.Add(recentProductsDiv1);
            mainContent.Controls.Add(recentProductsDiv2);
        }
    }
}