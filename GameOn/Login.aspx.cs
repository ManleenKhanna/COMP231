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

namespace Footworks
{
    public partial class Login : System.Web.UI.Page
    {
        private string strConnString = ConfigurationManager.ConnectionStrings["FootworksDBConnectionString"].ConnectionString;
        private DataTable dataTable;
        protected void Page_Load(object sender, EventArgs e)
        {
            LoginControl.FindControl("RememberMe").Visible = false;
        }

        protected void LoginControl_Authenticate(object sender, AuthenticateEventArgs e)
        {
            string user_username = LoginControl.UserName;
            string user_password = LoginControl.Password;
            BindData(user_username, user_password);
            int i = dataTable.Rows.Count;
            if (dataTable.Rows.Count > 0)
            {
                FormsAuthentication.RedirectFromLoginPage(dataTable.Rows[0][0].ToString(), LoginControl.RememberMeSet);
            }

        }

        private void BindData(string username, string password)
        {
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_user_find_by_username_password", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@user_username", SqlDbType.NVarChar).Value = username;
            cmd.Parameters.Add("@user_password", SqlDbType.NVarChar).Value = password;

            dataTable = GetData(cmd);
        }
        private DataTable GetData(SqlCommand cmd)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(strConnString);
            SqlDataAdapter sda = new SqlDataAdapter();
            try
            {
                cmd.Connection = con;
                con.Open();
                sda.SelectCommand = cmd;
                sda.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {

            }
            finally
            {
                con.Close();
            }
            return dt;

        }
    }
}