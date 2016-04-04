using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Linq;

namespace GameOn
{
    public partial class Main : System.Web.UI.MasterPage
    {
        string con1 = ConfigurationManager.ConnectionStrings["FootworksDBConnectionString"].ConnectionString;
        SqlConnection sqlcon;

        protected DataTable dtCategories;
        public string[] names;
        public JavaScriptSerializer javaSerial = new JavaScriptSerializer();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["FootworksDBConnectionString"].ConnectionString);
        List<string> stringList = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadDataTable();
        }

        protected void Page_Deactivate(object sender, EventArgs e)
        {
            unLoadCart();
        }

        protected void unLoadCart()
        {
            string userID = Session["UserID"].ToString();

            string sql = "DELETE FROM Cart WHERE UserID = '" + userID + "'";

            try
            {
                sqlcon = new SqlConnection(con1);
                sqlcon.Open();
                SqlCommand cmd = new SqlCommand(sql);
                cmd.CommandType = CommandType.Text;
                cmd.Connection = sqlcon;
                cmd.ExecuteNonQuery();
            }
            catch (SqlException exp)
            {

            }
        }

        private void LoadDataTable()
        {

            {
                con.Open();
                using (SqlDataAdapter adapter = new SqlDataAdapter("Select ProductName from Product", con))
                {
                    dtCategories = new DataTable();
                    adapter.Fill(dtCategories);
                }
                con.Close();
            }

            foreach (DataRow row in dtCategories.Rows)
            {

                stringList.Add(row[0].ToString());

            }

            names = stringList.ToArray();


        }
    }
}