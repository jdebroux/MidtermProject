package com.skilldistillery.chooseadventure.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
public class Wildlife {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@Column(name="link_wiki")
	private String link;
	
	@ManyToMany(cascade= {CascadeType.PERSIST, CascadeType.REMOVE})
	@JoinTable(name="national_park_wildlife", joinColumns=@JoinColumn(name="wildlife_id"),
	inverseJoinColumns=@JoinColumn(name="national_park_id"))
	private List<NationalPark> nationalParks;
	
	
	public Wildlife() {
	}

	public Wildlife(String name, String link) {
		super();
		this.name = name;
		this.link = link;
	}
	
	public void addNationalPark(NationalPark nationalPark) {
		if(nationalParks == null) {
			nationalParks = new ArrayList<>();
		}
		if(!nationalParks.contains(nationalPark)) {
			nationalParks.add(nationalPark);
			nationalPark.addWildlife(this);
		}
	}
	
	public void removeNationalPark(NationalPark nationalPark) {
		if(nationalParks != null && nationalParks.contains(nationalPark)) {
			nationalParks.remove(nationalPark);
			nationalPark.removeWildlife(this);
		}
	}

	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}

	public List<NationalPark> getNationalParks() {
		return new ArrayList<>(nationalParks);
	}

	public void setNationalParks(List<NationalPark> nationalParks) {
		this.nationalParks = nationalParks;
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
		Wildlife other = (Wildlife) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Wildlife [id=" + id + ", name=" + name + ", link=" + link + "]";
	}
}
