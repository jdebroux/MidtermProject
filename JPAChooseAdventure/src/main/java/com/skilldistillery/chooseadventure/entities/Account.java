package com.skilldistillery.chooseadventure.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Account {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String username;
	
	private String password;
	
	private Boolean active;
	
	@Column(name = "first_name")
	private String firstName;
	
	@Column(name = "last_name")
	private String lastName;
	
	@Column(name = "email_address")
	private String email;
	
	@OneToMany(mappedBy="account")
	private List<Trip> trips;

	public Account() {
	}

	public Account(int id, String username, String password, Boolean active, String firstName, String lastName) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.active = active;
		this.firstName = firstName;
		this.lastName = lastName;
	}

	public Account(String username, String password, Boolean active, String firstName, String lastName, String email) {
		super();
		this.username = username;
		this.password = password;
		this.active = active;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
	}
	
	public void addTrip(Trip trip) {
		if(trips == null) trips = new ArrayList<>();
		
		if(!trips.contains(trip)) {
			trips.add(trip);
			if(trip.getAccount() != null) {
				trip.getAccount().getTrips().remove(trip);
			}
			trip.setAccount(this);
		}
	}
	
	public void removeTrip(Trip trip) {
		trip.setAccount(null);
		if(trips != null) {
			trips.remove(trip);
		}
	}

	public int getId() {
		return id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getEnabled() {
		return active;
	}

	public void setEnabled(Boolean enabled) {
		this.active = enabled;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public List<Trip> getTrips() {
		return new ArrayList<>(trips);
	}

	public void setTrips(List<Trip> trips) {
		this.trips = trips;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Account other = (Account) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", active=" + active
				+ ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email + "]";
	}
}
