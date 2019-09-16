package com.skilldistillery.chooseadventure.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

@Entity
public class Location {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String state;
	
	
	private Double latitude;
	
	private Double longitude;
	
	@ManyToOne
	@JoinColumn(name="region_id")
	private Region region;
	
	@OneToOne(mappedBy="location")
	private NationalPark nationalPark;

	public Location() {
	}

	public Location(String state, Double latitude, Double longitude) {
		this.state = state;
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public int getId() {
		return id;
	}
	
	public Region getRegion() {
		return region;
	}

	public void setRegion(Region region) {
		this.region = region;
	}

	public NationalPark getNationalPark() {
		return nationalPark;
	}

	public void setNationalPark(NationalPark nationalPark) {
		this.nationalPark = nationalPark;
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
		Location other = (Location) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Location [id=" + id + ", state=" + state + ", latitude=" + latitude + ", longitude=" + longitude +"]";
	}
}

