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

namespace Admin.SubCategories
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
            SqlCommand cmd = new SqlCommand("sp_sub_category_get_all", con);
            cmd.CommandType = CommandType.StoredProcedure;

            GridViewSubCategories.DataSource = GetData(cmd);
            GridViewSubCategories.DataBind();
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
            GridViewSubCategories.PageIndex = e.NewPageIndex;
            GridViewSubCategories.DataBind();
        }

        protected void EditSubCategory(object sender, GridViewEditEventArgs e)
        {
            GridViewSubCategories.EditIndex = e.NewEditIndex;
            string label_category_name = ((Label)GridViewSubCategories.Rows[e.NewEditIndex].FindControl("label_category_name")).Text;
            BindData();
            ((DropDownList)GridViewSubCategories.Rows[e.NewEditIndex].FindControl("dropDownList_edit_category")).Items.FindByText(label_category_name).Selected = true;
        }
        protected void CancelEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewSubCategories.EditIndex = -1;
            BindData();
        }

        protected void UpdateSubCategory(object sender, GridViewUpdateEventArgs e)
        {
            string sub_category_id = ((Label)GridViewSubCategories.Rows[e.RowIndex].FindControl("label_sub_category_id")).Text;
            string sub_category_name = ((TextBox)GridViewSubCategories.Rows[e.RowIndex].FindControl("text_edit_sub_category_name")).Text;
            string category_id = ((DropDownList)GridViewSubCategories.Rows[e.RowIndex].FindControl("dropDownList_edit_category")).SelectedValue.ToString();



            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_sub_category_update", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@sub_category_id", SqlDbType.Int).Value = sub_category_id;
            cmd.Parameters.Add("@sub_category_name", SqlDbType.NVarChar).Value = sub_category_name;
            cmd.Parameters.Add("@category_id", SqlDbType.NVarChar).Value = category_id;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                //GridViewSubCategories.DataBind();
                GridViewSubCategories.EditIndex = -1;
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

        protected void AddNewSubCategory(object sender, EventArgs e)
        {
            string sub_category_name = ((TextBox)GridViewSubCategories.FooterRow.FindControl("text_add_sub_category_name")).Text;
            string category_id = ((DropDownList)GridViewSubCategories.FooterRow.FindControl("dropDownList_add_category")).SelectedValue.ToString();



            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_sub_category_insert", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@sub_category_name", SqlDbType.NVarChar).Value = sub_category_name;
            cmd.Parameters.Add("@category_id", SqlDbType.NVarChar).Value = category_id;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                //GridViewSubCategories.DataBind();
                //GridViewSubCategories.EditIndex = -1;
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

        protected void DeleteSubCategory(object sender, EventArgs e)
        {
            ImageButton imageButtonRemove = (ImageButton)sender;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("sp_sub_category_delete", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@sub_category_id", SqlDbType.Int).Value = imageButtonRemove.CommandArgument;

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

        protected void categoryChanged(object sender, EventArgs e)
        {
            DropDownList ddlCategory = (DropDownList)sender;
            String category_id = ddlCategory.SelectedValue;

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd;

            if (category_id.Equals("ALL"))
            {
                cmd = new SqlCommand();
                cmd = new SqlCommand("sp_sub_category_get_all", con);
                cmd.CommandType = CommandType.StoredProcedure;
            }
            else
            {
                cmd = new SqlCommand();
                cmd = new SqlCommand("sp_sub_category_get_all_by_category_id", con);
                cmd.Parameters.Add("@category_id", SqlDbType.Int).Value = category_id;
                cmd.CommandType = CommandType.StoredProcedure;
            }

            DataTable dt = new DataTable();
            dt = GetData(cmd);
            if (dt.Rows.Count != 0)
            {
                GridViewSubCategories.DataSource = dt;
                GridViewSubCategories.DataBind();
            }
            else
            {
                dt.Rows.Add(dt.NewRow());
                GridViewSubCategories.DataSource = dt;
                GridViewSubCategories.DataBind();
                GridViewSubCategories.Rows[0].Visible = false;
            }

            ((DropDownList)GridViewSubCategories.HeaderRow.FindControl("dropDownList_header_category")).Items.FindByValue(category_id).Selected = true;

        }
    }
}