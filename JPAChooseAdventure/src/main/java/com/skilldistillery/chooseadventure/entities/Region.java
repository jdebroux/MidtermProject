package com.skilldistillery.chooseadventure.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Region {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@OneToMany(mappedBy="region")
	private List<Location> locations;

	public Region() {
	}

	public Region(String name) {
		this.name = name;
	}
	
	public void addLocation(Location location) {
		if(locations == null) locations = new ArrayList<>();
		
		if(!locations.contains(location)) {
			locations.add(location);
			if(location.getRegion() != null) {
				location.getRegion().getLocations().remove(location);
			}
			location.setRegion(this);
		}
	}
	
	public void removeLocation(Location location) {
		location.setRegion(null);
		if(locations != null) {
			locations.remove(location);
		}
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
	
	public List<Location> getLocations() {
		return new ArrayList<>(locations);
	}

	public void setLocations(List<Location> locations) {
		this.locations = locations;
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
		Region other = (Region) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Region [id=" + id + ", name=" + name + "]";
	}
}
