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

namespace Admin.Departments
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
            SqlCommand cmd = new SqlCommand("sp_department_get_all", con);
            cmd.CommandType = CommandType.StoredProcedure;

            GridViewDepartments.DataSource = GetData(cmd);
            GridViewDepartments.DataBind();
        }

        private DataTable GetData(SqlCommand cmd)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(strConnString);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            return dt;
        }

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            BindData();
            GridViewDepartments.PageIndex = e.NewPageIndex;
            GridViewDepartments.DataBind();
        }

        protected void EditDepartment(object sender, GridViewEditEventArgs e)
        {
            GridViewDepartments.EditIndex = e.NewEditIndex;
            //string label_category_name = ((Label)GridViewDepartments.Rows[e.NewEditIndex].FindControl("label_department_id")).Text;
            BindData();
        }
        protected void CancelEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewDepartments.EditIndex = -1;
            BindData();
        }

        protected void UpdateDepartment(object sender, GridViewUpdateEventArgs e)
        {
            string department_id = ((Label)GridViewDepartments.Rows[e.RowIndex].FindControl("label_department_id")).Text;
            string department_name = ((TextBox)GridViewDepartments.Rows[e.RowIndex].FindControl("text_edit_department_name")).Text;
           


            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_department_update", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@department_id", SqlDbType.Int).Value = department_id;
            cmd.Parameters.Add("@department_name", SqlDbType.NVarChar).Value = department_name;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                //GridViewDepartments.DataBind();
                GridViewDepartments.EditIndex = -1;
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

        protected void AddNewDepartment(object sender, EventArgs e)
        {
            string department_name = ((TextBox)GridViewDepartments.FooterRow.FindControl("text_add_department_name")).Text;
            


            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_department_insert", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@department_name", SqlDbType.NVarChar).Value = department_name;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                //GridViewDepartments.DataBind();
                //GridViewDepartments.EditIndex = -1;
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

        protected void DeleteDepartment(object sender, EventArgs e)
        {
            ImageButton imageButtonRemove = (ImageButton)sender;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_department_delete", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@department_id", SqlDbType.Int).Value = imageButtonRemove.CommandArgument;

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