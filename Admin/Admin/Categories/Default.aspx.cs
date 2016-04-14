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

namespace Admin.Categories
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
            SqlCommand cmd = new SqlCommand("sp_category_get_all", con);
            cmd.CommandType = CommandType.StoredProcedure;

            GridViewCategories.DataSource = GetData(cmd);
            GridViewCategories.DataBind();
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
            GridViewCategories.PageIndex = e.NewPageIndex;
            GridViewCategories.DataBind();
        }

        protected void EditCategory(object sender, GridViewEditEventArgs e)
        {
            GridViewCategories.EditIndex = e.NewEditIndex;
            string label_department_name = ((Label)GridViewCategories.Rows[e.NewEditIndex].FindControl("label_department_name")).Text;
            BindData();
            ((DropDownList)GridViewCategories.Rows[e.NewEditIndex].FindControl("dropDownList_edit_Department")).Items.FindByText(label_department_name).Selected = true;
        }
        protected void CancelEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewCategories.EditIndex = -1;
            BindData();
        }

        protected void UpdateCategory(object sender, GridViewUpdateEventArgs e)
        {
            string category_id = ((Label)GridViewCategories.Rows[e.RowIndex].FindControl("label_category_id")).Text;
            string category_name = ((TextBox)GridViewCategories.Rows[e.RowIndex].FindControl("text_edit_category_name")).Text;
            string department_id = ((DropDownList)GridViewCategories.Rows[e.RowIndex].FindControl("dropDownList_edit_department")).SelectedValue.ToString();



            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_category_update", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@category_id", SqlDbType.Int).Value = category_id;
            cmd.Parameters.Add("@category_name", SqlDbType.NVarChar).Value = category_name;
            cmd.Parameters.Add("@department_id", SqlDbType.NVarChar).Value = department_id;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                //GridViewCategories.DataBind();
                GridViewCategories.EditIndex = -1;
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

        protected void AddNewCategory(object sender, EventArgs e)
        {
            string category_name = ((TextBox)GridViewCategories.FooterRow.FindControl("text_add_category_name")).Text;
            string department_id = ((DropDownList)GridViewCategories.FooterRow.FindControl("dropDownList_add_department")).SelectedValue.ToString();



            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_category_insert", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@category_name", SqlDbType.NVarChar).Value = category_name;
            cmd.Parameters.Add("@department_id", SqlDbType.NVarChar).Value = department_id;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                //GridViewCategories.DataBind();
                //GridViewCategories.EditIndex = -1;
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

        protected void DeleteCategory(object sender, EventArgs e)
        {
            ImageButton imageButtonRemove = (ImageButton)sender;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_category_delete", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@category_id", SqlDbType.Int).Value = imageButtonRemove.CommandArgument;

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

        protected void departmentChanged(object sender, EventArgs e)
        {
            DropDownList ddlDepartment = (DropDownList)sender;
            String department_id = ddlDepartment.SelectedValue;

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd;
            
            if (department_id.Equals("ALL"))
            {
                cmd = new SqlCommand();
                cmd = new SqlCommand("sp_category_get_all", con);
                cmd.CommandType = CommandType.StoredProcedure;
            }
            else
            {
                cmd = new SqlCommand();
                cmd = new SqlCommand("sp_category_get_all_by_department_id", con);
                cmd.Parameters.Add("@department_id", SqlDbType.Int).Value = department_id;
                cmd.CommandType = CommandType.StoredProcedure;
            }

            DataTable dt = new DataTable();
            dt = GetData(cmd);
            if (dt.Rows.Count != 0)
            {
                GridViewCategories.DataSource = dt;
                GridViewCategories.DataBind();
            }
            else
            {
                dt.Rows.Add(dt.NewRow());
                GridViewCategories.DataSource = dt;
                GridViewCategories.DataBind();
                GridViewCategories.Rows[0].Visible = false;
            }

            ((DropDownList)GridViewCategories.HeaderRow.FindControl("dropDownList_header_department")).Items.FindByValue(department_id).Selected = true;

        }
    }
}