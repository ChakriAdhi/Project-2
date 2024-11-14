using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Test_template
{
    public partial class ServiceRepairCheck : System.Web.UI.Page
    {
        string connectionString = "data source=CHAKRI_HP; initial catalog=msmavas; user id=Chakradhar; password=Chakradhar";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadServiceData();
            }
        }

        private void LoadServiceData()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM ServiceData WHERE IsActive = 1 ", con))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            gvServiceData.DataSource = dt;
                            gvServiceData.DataBind();
                            if (dt.Columns.Contains("ServiceNumber"))
                            {
                                // Proceed to bind the data
                                gvServiceData.DataSource = dt;
                                gvServiceData.DataBind();
                            }
                            else
                            {
                                lblMessage.Text = "ServiceNumber column not found in the data.";
                                lblMessage.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading data: " + ex.Message;
                lblMessage.Visible = true;
            }
        }
        // Method to insert a new record into the service data
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("ManageServiceData", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Action", "INSERT");
                        cmd.Parameters.AddWithValue("@ServiceDate", txtServiceDate.Text);
                        cmd.Parameters.AddWithValue("@ServiceType", txtServiceType.Text);
                        cmd.Parameters.AddWithValue("@ServiceDetails", txtServiceDetails.Text);
                        cmd.Parameters.AddWithValue("@VehicleModel", txtVehicleModel.Text);
                        cmd.Parameters.AddWithValue("@CustomerName", txtCustomerName.Text);
                        cmd.Parameters.AddWithValue("@ContactNumber", txtContactNumber.Text);
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        lblSuccessMessage.Text = "Record inserted successfully!";
                        lblSuccessMessage.Visible = true;
                        LoadServiceData(); // Refresh GridView
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error inserting data: " + ex.Message;
                lblMessage.Visible = true;
            }
        }
        // Method to clear all input fields
        private void ClearFields()
        {
            txtServiceDate.Text = string.Empty;
            txtServiceType.Text = string.Empty;
            txtServiceDetails.Text = string.Empty;
            txtVehicleModel.Text = string.Empty;
            txtCustomerName.Text = string.Empty;
            txtContactNumber.Text = string.Empty;
            txtEmail.Text = string.Empty;
        }
        // Method to enable editing in GridView
        protected void gvServiceData_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvServiceData.EditIndex = e.NewEditIndex;
            LoadServiceData();
        }
        // Method to update a record in the database
        protected void gvServiceData_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = gvServiceData.Rows[e.RowIndex];
                int serviceNumber = Convert.ToInt32(gvServiceData.DataKeys[e.RowIndex].Value);
                string serviceDate = (row.FindControl("txtServiceDate") as TextBox).Text;
                string serviceType = (row.FindControl("txtServiceType") as TextBox).Text;
                string serviceDetails = (row.FindControl("txtServiceDetails") as TextBox).Text;
                string vehicleModel = (row.FindControl("txtVehicleModel") as TextBox).Text;
                string customerName = (row.FindControl("txtCustomerName") as TextBox).Text;
                string contactNumber = (row.FindControl("txtContactNumber") as TextBox).Text;
                string email = (row.FindControl("txtEmail") as TextBox).Text;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("ManageServiceData", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Action", "UPDATE");
                        cmd.Parameters.AddWithValue("@ServiceNumber", serviceNumber);
                        cmd.Parameters.AddWithValue("@ServiceDate", serviceDate);
                        cmd.Parameters.AddWithValue("@ServiceType", serviceType);
                        cmd.Parameters.AddWithValue("@ServiceDetails", serviceDetails);
                        cmd.Parameters.AddWithValue("@VehicleModel", vehicleModel);
                        cmd.Parameters.AddWithValue("@CustomerName", customerName);
                        cmd.Parameters.AddWithValue("@ContactNumber", contactNumber);
                        cmd.Parameters.AddWithValue("@Email", email);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        lblSuccessMessage.Text = "Record updated successfully!";
                        lblSuccessMessage.Visible = true;
                        gvServiceData.EditIndex = -1;
                        LoadServiceData(); // Refresh GridView
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error updating data: " + ex.Message;
                lblMessage.Visible = true;
            }
        }

        protected void gvServiceData_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvServiceData.EditIndex = -1;
            LoadServiceData();
        }

        protected void gvServiceData_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int serviceNumber = Convert.ToInt32(gvServiceData.DataKeys[e.RowIndex].Value);

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("ManageServiceData", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Action", "DELETE");
                        cmd.Parameters.AddWithValue("@ServiceNumber", serviceNumber);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        lblSuccessMessage.Text = "Record deleted successfully!";
                        lblSuccessMessage.Visible = true;
                        LoadServiceData(); // Refresh GridView
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error deleting data: " + ex.Message;
                lblMessage.Visible = true;
            }
        }
    }
}
