package com.skilldistillery.chooseadventure.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name="geo_feature")
public class GeoFeature {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;

	@ManyToMany(cascade= {CascadeType.PERSIST, CascadeType.REMOVE})
	@JoinTable(name="national_park", joinColumns=@JoinColumn(name="geo_feature_id"),
	inverseJoinColumns=@JoinColumn(name="national_park_id"))
	private List<NationalPark> nationalParks;
	
	public GeoFeature() {
	}

	public GeoFeature(String name) {
		this.name = name;
	}
	
	public void addNationalPark(NationalPark nationalPark) {
		if(nationalParks == null) {
			nationalParks = new ArrayList<>();
		}
		if(!nationalParks.contains(nationalPark)) {
			nationalParks.add(nationalPark);
			nationalPark.addGeoFeature(this);
		}
	}
	
	public void removeNationalPark(NationalPark nationalPark) {
		if(nationalParks != null && nationalParks.contains(nationalPark)) {
			nationalParks.remove(nationalPark);
			nationalPark.removeGeoFeature(this);
		}
	}

	public String getName() {
		return name;
	}
	
	public List<NationalPark> getNationalParks() {
		return nationalParks;
	}

	public void setNationalParks(List<NationalPark> nationalParks) {
		this.nationalParks = nationalParks;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getId() {
		return id;
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
		GeoFeature other = (GeoFeature) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "GeoFeature [id=" + id + ", name=" + name + "]";
	}
}
