package com.reports;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.attendance.DatabaseConnection;
import com.bean.Question;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@WebServlet("/AdminQuizReport")
public class AdminQuizResults extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Font TIME_ROMAN = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
	private static Font TIME_ROMAN_SMALL = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		final ServletContext servletContext = request.getSession().getServletContext();
		final File tempDirectory = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
		final String temperotyFilePath = tempDirectory.getAbsolutePath();
		System.out.println(temperotyFilePath);
		String fileName = "Quiz_Results_Report_" + System.currentTimeMillis() + ".pdf";
		try {
			response.setContentType("application/pdf");
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Cache-Control", "max-age=0");
			response.setHeader("Content-disposition", "attachment; " + "filename=" + fileName);

			// Create PDF document
			Document document = new Document(PageSize.A4);
			PdfWriter.getInstance(document, response.getOutputStream());
			document.open();
			// document.add(new Chunk("Quiz Results"));

			// Add Heading
			Paragraph heading = new Paragraph("Quiz Result Report ", TIME_ROMAN);
			heading.setAlignment(Paragraph.ALIGN_CENTER);
			document.add(heading);
			Paragraph preface = new Paragraph();
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");
			// Adding empty paragraph
			preface.add(new Paragraph("\n"));
			preface.add(
					new Paragraph("Quiz Result Report on " + simpleDateFormat.format(new Date()), TIME_ROMAN_SMALL));

			document.add(preface);
			document.add(new Paragraph("\n"));
			// Add Meta data

			document.addTitle("Quiz Result report");
			document.addSubject("Quiz Result report");
			document.addAuthor("Amey Shinde");
			document.addCreator("Amey Shinde");

			// Add Title Page

			// Create table with five columns
			PdfPTable table = new PdfPTable(5);

			// Add table headers
			PdfPCell c1 = new PdfPCell(new Phrase("Quiz No"));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);

			c1 = new PdfPCell(new Phrase("User Name"));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);

			c1 = new PdfPCell(new Phrase("Selected Answer"));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);

			c1 = new PdfPCell(new Phrase("Correct Answer"));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);

			c1 = new PdfPCell(new Phrase("Subject"));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);

			table.setHeaderRows(1);

			PdfPCell[] cells = table.getRow(0).getCells();
			for (int j = 0; j < cells.length; j++) {
				cells[j].setBorderColor(BaseColor.BLACK);
				cells[j].setBackgroundColor(BaseColor.GRAY);
			}

			try {
				PdfPCell TableCell = null;
				table.setWidthPercentage(100);
				table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
				HttpSession session = request.getSession();
				String subjectdisplay = (String) session.getAttribute("Subject");
				ResultSet resultset = DatabaseConnection.getResultFromSqlQuery(
						"SELECT DISTINCT * FROM quiz_answers CROSS JOIN apti_answers");
				if (!resultset.next()) {
					// No records found
					document.add(new Paragraph("No Records found"));
				} else {
					// Add records to table
					do {
						String quizno = resultset.getString("quiz_no");
						String username = resultset.getString("username");
						String userans = resultset.getString("userans");
						String correctans = resultset.getString("correctans");
						String subject = resultset.getString("subject");
						TableCell = new PdfPCell(new Phrase(quizno));
						table.addCell(TableCell);
						TableCell = new PdfPCell(new Phrase(username));
						table.addCell(TableCell);
						TableCell = new PdfPCell(new Phrase(userans));
						table.addCell(TableCell);
						TableCell = new PdfPCell(new Phrase(correctans));
						table.addCell(TableCell);
						TableCell = new PdfPCell(new Phrase(subject));
						table.addCell(TableCell);
					} while (resultset.next());
					// Add table to document
					document.add(table);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			// Close document
			document.close();

		} catch (DocumentException e) {
			e.printStackTrace();
		}
	}
}
