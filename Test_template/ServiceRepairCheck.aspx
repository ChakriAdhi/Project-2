<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ServiceRepairCheck.aspx.cs" Inherits="Test_template.ServiceRepairCheck" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Service Repair Data</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
 <style>
        body {
            background-color: #f0f8ff; /* Light cyan background color */
            font-family: Arial, sans-serif;
        }
        .form-container {
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #ffffff; /* White background for the form */
            width: 100%;
        }
        .result-container {
            margin-top: 20px;
        }
        .grid-container {
            overflow-x: auto; /* Enable horizontal scroll */
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #ffffff; /* White background for the grid */
        }
        h2 {
            color: #333; /* Darker color for the header text */
        }
        label {
            font-weight: bold;
            color: #555; /* Slightly lighter color for labels */
        }
        .btn-primary {
            background-color: #4CAF50; /* Green color for buttons */
            border-color: #4CAF50;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2 class="my-4 text-center">Manage Service Repair Data</h2>
            
            <!-- Centered Form Section -->
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="form-container">
                        <h4>Insert Data</h4>
                        <div class="form-group">
                            <label for="txtServiceDate">Service Date:</label>
                            <asp:TextBox ID="txtServiceDate" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="txtServiceType">Service Type:</label>
                            <asp:TextBox ID="txtServiceType" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="txtServiceDetails">Service Details:</label>
                            <asp:TextBox ID="txtServiceDetails" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="txtVehicleModel">Vehicle Model:</label>
                            <asp:TextBox ID="txtVehicleModel" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="txtCustomerName">Customer Name:</label>
                            <asp:TextBox ID="txtCustomerName" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="txtContactNumber">Contact Number:</label>
                            <asp:TextBox ID="txtContactNumber" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="txtEmail">Email:</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                        </div>

                        <!-- Insert Button -->
                        <div class="form-group">
                            <asp:Button ID="btnInsert" runat="server" Text="Insert" CssClass="btn btn-primary" OnClick="btnInsert_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- GridView Section Under Insert Form -->
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="grid-container">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" Visible="False"></asp:Label>
                        <asp:Label ID="lblSuccessMessage" runat="server" CssClass="text-success" Visible="False"></asp:Label>
                        <asp:GridView ID="gvServiceData" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
                            OnRowEditing="gvServiceData_RowEditing" OnRowUpdating="gvServiceData_RowUpdating" OnRowCancelingEdit="gvServiceData_RowCancelingEdit"
                            OnRowDeleting="gvServiceData_RowDeleting" DataKeyNames="ServiceNumber">
                            <Columns>
                                 <asp:TemplateField HeaderText="Service Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblServiceDate" runat="server" Text='<%# Eval("ServiceDate") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtServiceDate" runat="server" Text='<%# Bind("ServiceDate") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Service Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblServiceType" runat="server" Text='<%# Eval("ServiceType") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtServiceType" runat="server" Text='<%# Bind("ServiceType") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Service Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblServiceDetails" runat="server" Text='<%# Eval("ServiceDetails") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtServiceDetails" runat="server" Text='<%# Bind("ServiceDetails") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vehicle Model">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleModel" runat="server" Text='<%# Eval("VehicleModel") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtVehicleModel" runat="server" Text='<%# Bind("VehicleModel") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Customer Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCustomerName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCustomerName" runat="server" Text='<%# Bind("CustomerName") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Contact Number">
                                    <ItemTemplate>
                                        <asp:Label ID="lblContactNumber" runat="server" Text='<%# Eval("ContactNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtContactNumber" runat="server" Text='<%# Bind("ContactNumber") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
