package com.skilldistillery.chooseadventure.entities;

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
	
	@Column(name="national_park_id")
	private int nationalParkId;
	@Column(name="user_id")
	private int userId;

	@OneToMany(mappedBy="trip")
	private TripActivity tripActivity;

	@OneToMany(mappedBy="trip")
	private TripComment tripComment;
	
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

	public int getNationalParkId() {
		return nationalParkId;
	}

	public void setNationalParkId(int nationalParkId) {
		this.nationalParkId = nationalParkId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public TripActivity getTripActivity() {
		return tripActivity;
	}

	public void setTripActivity(TripActivity tripActivity) {
		this.tripActivity = tripActivity;
	}

	public TripComment getTripComment() {
		return tripComment;
	}

	public void setTripComment(TripComment tripComment) {
		this.tripComment = tripComment;
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
		return "Trip [id=" + id + ", name=" + name + ", tripComment=" + tripComment + ", nationalPark=" + nationalPark
				+ ", user=" + user + "]";
	}
}
