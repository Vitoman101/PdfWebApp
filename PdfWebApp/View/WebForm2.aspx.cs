using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PDFReader;

namespace PdfWebApp.View
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void btnReset_Click(object sender, EventArgs e)
        {

            DirectoryInfo di = new DirectoryInfo(Server.MapPath("~/Files/"));

            foreach (FileInfo file in di.GetFiles())
            {
                file.Delete();
            }

            Response.Redirect("WebForm2.aspx");
        }
        protected void uploadFile_Click(object sender, System.EventArgs e)
        {
            string strFolder;
            string strFilePath;
            strFolder = Server.MapPath("~/Files/");

            if (!Directory.Exists(strFolder))
            {
                Directory.CreateDirectory(strFolder);
            }

            if (UploadPDFs.HasFiles)
            {
                if (UploadPDFs.PostedFiles.Count > 2)
                {
                    lblError.Text = "Dozvoljeno najvise 2 fajla upload.";
                } 
                else
                {
                    foreach (HttpPostedFile uploadedFile in UploadPDFs.PostedFiles)
                    {
                        strFilePath = strFolder + uploadedFile.FileName;
                        string extension = System.IO.Path.GetExtension(uploadedFile.FileName);

                        if (File.Exists(strFilePath))
                        {
                            string duplicate = Path.GetFileNameWithoutExtension(uploadedFile.FileName) + "(1).pdf";
                            uploadedFile.SaveAs(System.IO.Path.Combine(strFolder, duplicate));
                            listofuploadedfiles.Text += String.Format("{0}<br />", duplicate);
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

        protected void calculate_Click(object sender, System.EventArgs e)
        {
            Reader reader = new Reader();
            var list = Reader.getAllFilesInFolder(Server.MapPath("~/Files/"));
            try
            {
                bool isEmpty = !list.Any();
                if (!isEmpty)
                {
                    statusBar.InnerHtml = "Citanje prvog fajla";
                    progressBar.Style["width"] = "20%";
                    var first = reader.uniqueWords(list[0]);
                    statusBar.InnerText = "Citanje drrugog fajla";
                    progressBar.Style["width"] = "40%";
                    var second = reader.uniqueWords(list[1]);

                    statusBar.InnerText = "Uklanjanje nepotrebnih reci";
                    progressBar.Style["width"] = "60%";
                    first = Reader.removeTopN(first, 10, 15);
                    second = Reader.removeTopN(second, 10, 15);

                    statusBar.InnerText = "Zavrsno merenje";
                    progressBar.Style["width"] = "90%";
                    var distance = LevenshteinDistance.distanceMeasure(first, second, 2);
                    distance = ((1 - distance) * 100);
                    statusBar.InnerText = "Gotovo";
                    progressBar.Style["width"] = "100%";
                    result.InnerText = distance.ToString();
                }
                else
                {
                    lblError.Text = "Files not found on server";
                }
            }
            catch(Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }
    }
}