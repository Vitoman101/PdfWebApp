using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PdfWebApp.View
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void btnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("WebForm2.aspx");
        }
        protected void uploadFile_Click(object sender, System.EventArgs e)
        {
            string strFolder;
            string strFilePath;
            strFolder = Server.MapPath("~/Files/");

            if (UploadPDFs.HasFiles)
            {
                foreach (HttpPostedFile uploadedFile in UploadPDFs.PostedFiles)
                {
                    strFilePath = strFolder + uploadedFile.FileName;
                    string extension = System.IO.Path.GetExtension(uploadedFile.FileName);

                    if (File.Exists(strFilePath))
                    {
                        lblError.Text += String.Format("{0}<br /> ", uploadedFile.FileName + " already exists on server.");
                    }
                    else if (extension != ".pdf")
                    {
                        lblError.Text += String.Format("{0}<br /> ", uploadedFile.FileName + " file is not .pdf format.");
                    }
                    else
                    {
                        uploadedFile.SaveAs(System.IO.Path.Combine(strFolder, uploadedFile.FileName));
                        listofuploadedfiles.Text += String.Format("{0}<br />", uploadedFile.FileName);
                    }
                }
            }
        }
    }
}