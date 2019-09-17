package com.skilldistillery.chooseadventure.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "national_park")
public class NationalPark {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	private String description;

	@Column(name = "link_image_url")
	private String picture;

	@Column(name = "link_nps")
	private String link;

	@OneToMany(mappedBy = "nationalPark")
	private List<NationalParkActivity> nationalParkActivities;

	@OneToMany(mappedBy = "nationalPark")
	private List<Trip> trips;

	@OneToOne
	@JoinColumn(name = "location_id")
	private Location location;

	@ManyToMany(mappedBy = "nationalParks")
	private List<Wildlife> wildlifeList;

	@ManyToMany(mappedBy = "nationalParks")
	private List<VisitorType> visitorTypes;

	@ManyToMany(mappedBy = "nationalParks")
	private List<GeoFeature> geoFeatures;

	@ManyToMany(mappedBy = "nationalParks")
	private List<Activity> activities;

	public NationalPark() {
	}

	public NationalPark(String name, String description, String link) {
		this.name = name;
		this.description = description;
		this.link = link;
	}

	public void addNationalParkActivity(NationalParkActivity nationalParkActivity) {
		if (nationalParkActivities == null)
			nationalParkActivities = new ArrayList<>();

		if (!nationalParkActivities.contains(nationalParkActivity)) {
			nationalParkActivities.add(nationalParkActivity);
			if (nationalParkActivity.getNationalPark() != null) {
				nationalParkActivity.getNationalPark().getNationalParkActivities().remove(nationalParkActivity);
			}
			nationalParkActivity.setNationalPark(this);
		}
	}

	public void removeNationalParkActivity(NationalParkActivity nationalParkActivity) {
		nationalParkActivity.setNationalPark(null);
		if (nationalParkActivities != null) {
			nationalParkActivities.remove(nationalParkActivity);
		}
	}

	public void addWildlife(Wildlife wildlife) {
		if (wildlifeList == null) {
			wildlifeList = new ArrayList<>();
		}
		if (!wildlifeList.contains(wildlife)) {
			wildlifeList.add(wildlife);
			wildlife.addNationalPark(this);
		}
	}

	public void removeWildlife(Wildlife wildlife) {
		if (wildlifeList != null && wildlifeList.contains(wildlife)) {
			wildlifeList.remove(wildlife);
			wildlife.removeNationalPark(this);
		}
	}

	public void addActivity(Activity activity) {
		if (activities == null) {
			activities = new ArrayList<>();
		}
		if (!activities.contains(activity)) {
			activities.add(activity);
			activity.addNationalPark(this);
		}
	}

	public void removeActivity(Activity activity) {
		if (activities != null && activities.contains(activity)) {
			activities.remove(activity);
			activity.removeNationalPark(this);
		}
	}

	public void addVisitorType(VisitorType visitorType) {
		if (visitorTypes == null) {
			visitorTypes = new ArrayList<>();
		}
		if (!visitorTypes.contains(visitorType)) {
			visitorTypes.add(visitorType);
			visitorType.addNationalPark(this);
		}
	}

	public void removeVisitorType(VisitorType visitorType) {
		if (visitorTypes != null && visitorTypes.contains(visitorType)) {
			visitorTypes.remove(visitorType);
			visitorType.removeNationalPark(this);
		}
	}

	public void addGeoFeature(GeoFeature geoFeature) {
		if (geoFeatures == null) {
			geoFeatures = new ArrayList<>();
		}
		if (!geoFeatures.contains(geoFeature)) {
			geoFeatures.add(geoFeature);
			geoFeature.addNationalPark(this);
		}
	}

	public void removeGeoFeature(GeoFeature geoFeature) {
		if (geoFeatures != null && geoFeatures.contains(geoFeature)) {
			geoFeatures.remove(geoFeature);
			geoFeature.removeNationalPark(this);
		}
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public List<NationalParkActivity> getNationalParkActivities() {
		return new ArrayList<>(nationalParkActivities);
	}

	public void setNationalParkActivities(List<NationalParkActivity> nationalParkActivities) {
		this.nationalParkActivities = nationalParkActivities;
	}

	public List<Trip> getTrips() {
		return new ArrayList<>(trips);
	}

	public void setTrips(List<Trip> trips) {
		this.trips = trips;
	}

	public Location getLocation() {
		return location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}

	public List<Wildlife> getWildlifeList() {
		return new ArrayList<>(wildlifeList);
	}

	public void setWildlifeList(List<Wildlife> wildlifeList) {
		this.wildlifeList = wildlifeList;
	}

	public List<VisitorType> getVisitorTypes() {
		return new ArrayList<>(visitorTypes);
	}

	public void setVisitorTypes(List<VisitorType> visitorTypes) {
		this.visitorTypes = visitorTypes;
	}

	public List<GeoFeature> getGeoFeatures() {
		return new ArrayList<>(geoFeatures);
	}

	public void setGeoFeatures(List<GeoFeature> geoFeatures) {
		this.geoFeatures = geoFeatures;
	}

	public int getId() {
		return id;
	}

	public List<Activity> getActivities() {
		return new ArrayList<>(activities);
	}

	public void setActivities(List<Activity> activities) {
		this.activities = activities;
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
		NationalPark other = (NationalPark) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "NationalPark [id=" + id + ", name=" + name + ", description=" + description + ", location=" + location
				+ "]";
	}
}
