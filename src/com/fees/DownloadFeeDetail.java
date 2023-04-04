package com.fees;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/downloadFeeDetail")
public class DownloadFeeDetail extends HttpServlet {

	public int BUFFER_SIZE = 1024 * 1000; // 100MB

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String fileName = request.getParameter("fileName");

		String path = getServletContext().getRealPath("") + "fees" + File.separator + fileName;

		System.out.println(path);

		File file = new File(path);
		OutputStream os = null;
		FileInputStream fis = null;
		try {
			if (file.exists()) {
				response.setHeader("Content-Disposition", String.format("attachment;filename=\"%s\"", file.getName()));

				response.setContentType("application/octet-stream");

				os = response.getOutputStream();
				fis = new FileInputStream(file);

				byte[] bf = new byte[BUFFER_SIZE];
				int byteRead = -1;
				while ((byteRead = fis.read(bf)) != -1) {
					os.write(bf, 0, byteRead);
				}

			} else {
				response.setContentType("text/html");
				response.getWriter().print("<h4>File not found Named =" + fileName + "</h4>");

				System.out.println("The file is not found" + fileName);
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				fis.close();
			}
			os.flush();
			if (os != null) {
				os.close();
			}
		}

	}

}

