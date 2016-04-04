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
using GameOn;

namespace Footworks
{
    public partial class Cart : System.Web.UI.Page
    {
        private string strConnString = ConfigurationManager.ConnectionStrings["FootworksDBConnectionString"].ConnectionString;
        static DataTable cart;
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
            SqlCommand cmd = new SqlCommand("sp_get_cart_details_by_user_id", con);

            string userID = HttpContext.Current.User.Identity.Name;
            cmd.Parameters.Add("@user_id", SqlDbType.VarChar).Value = userID;

            cmd.CommandType = CommandType.StoredProcedure;

            cart = GetData(cmd);
            GridViewUsers.DataSource = cart;
            GridViewUsers.DataBind();
            calculateTotal();
        }

        private DataTable GetData(SqlCommand cmd)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(strConnString);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.Connection = con;
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            return dt;
        }

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            BindData();
            GridViewUsers.PageIndex = e.NewPageIndex;
            GridViewUsers.DataBind();
        }

        protected void DeleteCustomer(object sender, EventArgs e)
        {
            ImageButton imageButtonRemove = (ImageButton)sender;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_delete_cart_details_by_cart_id", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@cart_id", SqlDbType.Int).Value = imageButtonRemove.CommandArgument;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                BindData();
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

        private void calculateTotal()
        {
            float total = 0;
            for(int i = 0 ; i<cart.Rows.Count;i++)
            {
                try
                {
                    string str = cart.Rows[i][20].ToString();
                    total += float.Parse(str);
                }
                catch (Exception ex)
                { }
            }
            ((Label)GridViewUsers.FooterRow.FindControl("LabelTotal")).Text = total.ToString("C2");
        }

        protected void ButtonCheckout_Click(object sender, EventArgs e)
        {
            RemotePost myremotepost = new RemotePost();
            myremotepost.Url = "https://www.paypal.com/cgi-bin/webscr";
            myremotepost.Add("business", "sale@gameon.com");
            myremotepost.Add("cmd", "_xclick");
            myremotepost.Add("item_name", cart.Rows[0][11].ToString());
            myremotepost.Add("amount", ((Label)GridViewUsers.FooterRow.FindControl("LabelTotal")).Text);
            myremotepost.Add("currency_code", "CAD");
            myremotepost.Post();
            //Response.Redirect(redirect);
        }

        
    }
}