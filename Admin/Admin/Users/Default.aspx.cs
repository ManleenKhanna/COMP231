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

namespace Admin.Users
{
    public partial class Default : System.Web.UI.Page
    {
        private string strConnString = ConfigurationManager.ConnectionStrings["gameOnConnectionString"].ConnectionString;
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
            SqlCommand cmd = new SqlCommand("sp_user_get_all", con);
            cmd.CommandType = CommandType.StoredProcedure;

            GridViewUsers.DataSource = GetData(cmd);
            GridViewUsers.DataBind();
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

        protected void EditCustomer(object sender, GridViewEditEventArgs e)
        {
            GridViewUsers.EditIndex = e.NewEditIndex;
            //string label_category_name = ((Label)GridViewUsers.Rows[e.NewEditIndex].FindControl("label_user_id")).Text;
            BindData();
        }
        protected void CancelEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewUsers.EditIndex = -1;
            BindData();
        }

        protected void UpdateCustomer(object sender, GridViewUpdateEventArgs e)
        {
            string user_id = ((TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("text_edit_user_user_id")).Text;            
            string user_username = ((TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("text_edit_user_username")).Text;
            string user_password = ((TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("text_edit_user_password")).Text;
            string user_email = ((TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("text_edit_user_email")).Text;
            string user_phone = ((TextBox)GridViewUsers.Rows[e.RowIndex].FindControl("text_edit_user_phone")).Text;


            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_user_update", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@user_id", SqlDbType.NVarChar).Value = user_id;
            cmd.Parameters.Add("@user_username", SqlDbType.NVarChar).Value = user_username;
            cmd.Parameters.Add("@user_password", SqlDbType.NVarChar).Value = user_password;
            cmd.Parameters.Add("@user_email", SqlDbType.NVarChar).Value = user_email;
            cmd.Parameters.Add("@user_phone", SqlDbType.NVarChar).Value = user_phone;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                //GridViewUsers.DataBind();
                GridViewUsers.EditIndex = -1;
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

        protected void AddNewCustomer(object sender, EventArgs e)
        {
            string user_id = ((TextBox)GridViewUsers.FooterRow.FindControl("text_add_user_user_id")).Text;
            string user_username = ((TextBox)GridViewUsers.FooterRow.FindControl("text_add_user_username")).Text;
            string user_password = ((TextBox)GridViewUsers.FooterRow.FindControl("text_add_user_password")).Text;
            string user_email = ((TextBox)GridViewUsers.FooterRow.FindControl("text_add_user_email")).Text;
            string user_phone = ((TextBox)GridViewUsers.FooterRow.FindControl("text_add_user_phone")).Text;


            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_user_insert", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@user_userid", SqlDbType.NVarChar).Value = user_id;
            cmd.Parameters.Add("@user_username", SqlDbType.NVarChar).Value = user_username;
            cmd.Parameters.Add("@user_password", SqlDbType.NVarChar).Value = user_password;
            cmd.Parameters.Add("@user_email", SqlDbType.NVarChar).Value = user_email;
            cmd.Parameters.Add("@user_phone", SqlDbType.NVarChar).Value = user_phone;


            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                //GridViewUsers.DataBind();
                //GridViewUsers.EditIndex = -1;
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

        protected void DeleteCustomer(object sender, EventArgs e)
        {
            ImageButton imageButtonRemove = (ImageButton)sender;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_user_delete", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@user_id", SqlDbType.NVarChar).Value = imageButtonRemove.CommandArgument;

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
    }
}