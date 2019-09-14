package com.skilldistillery.chooseadventure.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Trip {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@OneToMany(mappedBy="trip")
	private List<TripActivity> tripActivities;

	@OneToMany(mappedBy="trip")
	private List<TripComment> tripComments;
	
	@ManyToOne
	@JoinColumn(name="national_park_id")
	private NationalPark nationalPark;

	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;

	public Trip() {
	}

	public Trip(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public List<TripActivity> getTripActivities() {
		return new ArrayList<>(tripActivities);
	}

	public void setTripActivities(List<TripActivity> tripActivities) {
		this.tripActivities = tripActivities;
	}

	public List<TripComment> getTripComments() {
		return new ArrayList<>(tripComments);
	}

	public void setTripComments(List<TripComment> tripComments) {
		this.tripComments = tripComments;
	}

	public NationalPark getNationalPark() {
		return nationalPark;
	}

	public void setNationalPark(NationalPark nationalPark) {
		this.nationalPark = nationalPark;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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
		Trip other = (Trip) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Trip [id=" + id + ", name=" + name + ", nationalPark=" + nationalPark
				+ ", user=" + user + "]";
	}
}
