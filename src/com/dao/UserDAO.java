package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.attendance.DatabaseConnection;

import com.model.User;

public class UserDAO {

	
	public static User getUserByEmail(String email) throws SQLException {
		Connection con = null;
		try {
			con = DatabaseConnection.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		PreparedStatement st = con.prepareStatement("SELECT * FROM students WHERE email = ?");
		st.setString(1, email);
		ResultSet rs = st.executeQuery();
		User u = null;
		if(rs.next()) {
			u = new User(rs.getInt("student_id"), rs.getString("stud_name"), rs.getString("email"));
		}
		con.close();
		return u;
	}
	
	public static User getUserById(int id) throws SQLException {
		Connection con = null;
		try {
			con = DatabaseConnection.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		PreparedStatement st = con.prepareStatement("SELECT * FROM students WHERE student_id = ?");
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		User u = null;
		if(rs.next()) {
			u = new User(rs.getInt("student_id"), rs.getString("stud_name"), rs.getString("email"));
		}
		con.close();
		return u;
	}
	public static User getFacultyById(int id) throws SQLException {
		Connection con = null;
		try {
			con = DatabaseConnection.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		PreparedStatement st = con.prepareStatement("SELECT * FROM faculty WHERE teacher_id = ?");
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		User u = null;
		if(rs.next()) {
			u = new User(rs.getInt("teacher_id"), rs.getString("teacher_name"), rs.getString("email"));
		}
		con.close();
		return u;
	}
}
