package com.xinruigao;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.*;
import java.util.Map;
import java.util.Map.Entry;
import java.lang.*;

public class DistanceCalculator {

    public static double distanceFromUser;
    public static ArrayList<Coordinates> recyclingBins;
    public static HashMap<Coordinates,Double> nearestBinsArray = new HashMap<Coordinates, Double>();
    public static Coordinates currentUserLocation;

    // method to create ArrayList from csv
    public static ArrayList<Double> getBinArray(String file) {
        ArrayList<Coordinates> coordList = new ArrayList<Coordinates>();
        ArrayList<Double> myCoordList = new ArrayList<Double>();
        BufferedReader br = null;
        String line = "";
        String cvsSplitBy = ",";

        try {
            br = new BufferedReader(new FileReader(file));
            while ((line = br.readLine()) != null) {
                // use comma as separator
                String[] coordString = line.split(cvsSplitBy);

                Coordinates coord = new Coordinates(Double.parseDouble(coordString[0]), (Double.parseDouble(coordString[1])));
//                coordList.add(coord);
                myCoordList.add(Double.parseDouble(coordString[0]));
                myCoordList.add(Double.parseDouble(coordString[1]));
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

//        return coordList;
        return myCoordList;
    }

    // compare distance
    public static HashMap<Coordinates, Double> compareDistance(Coordinates currentLocation, ArrayList<Coordinates> binsLocations) {
        double x1, y1, x2 = currentLocation.getX(), y2 = currentLocation.getY();

        HashMap<Coordinates, Double>  nearestBinsArray = new HashMap<Coordinates, Double>();

        // iterate through the HashMap
        for (int i=0; i< binsLocations.size(); i++) {
            x1 = binsLocations.get(i).getX();
            y1 = binsLocations.get(i).getY();
            distanceFromUser = Math.sqrt(Math.pow(x1-x2, 2)+Math.pow(y1-y2, 2));
            nearestBinsArray.put(binsLocations.get(i), distanceFromUser);
        }

        return nearestBinsArray;
    }

    // to sort the hashmap by values
    public static HashMap<Coordinates, Double> sortHashMap(HashMap<Coordinates, Double> nearestRecyclingBins) {

        List<Entry<Coordinates, Double>> list = new ArrayList<>(nearestRecyclingBins.entrySet());
        list.sort(Entry.comparingByValue());

        HashMap<Coordinates, Double> sortedMap =
                new LinkedHashMap<>();

        for (Entry<Coordinates, Double> entry : list) {
            sortedMap.put(entry.getKey(), entry.getValue());
        }

        return sortedMap;
    }


    // main method
    public static void main(String[] args) {

        Coordinates currentLocation = new Coordinates(1.354071, 103.940392);

        // location of csv file
        String csvFile = "../../assets/bins.csv";

        ArrayList<Coordinates> coordList = new ArrayList<Coordinates>();
        ArrayList<Double> myCoordList = new ArrayList<Double>();
        myCoordList = getBinArray(csvFile);
//        coordList = getBinArray(csvFile);
        System.out.println(myCoordList);

        // get the distance map
        HashMap<Coordinates, Double>  distanceMap = new HashMap<Coordinates, Double>();
        distanceMap = compareDistance(currentLocation, coordList);


        HashMap<Coordinates, Double>  sortedMap = new HashMap<Coordinates, Double>();
        sortedMap = sortHashMap(distanceMap);

        // print the top 10 results
        int i = 1;
        for (Coordinates name: sortedMap.keySet()){
            Coordinates key = name;
            Double value = sortedMap.get(name);
            System.out.println(key.getX() + ", " + key.getY() + " : " + value + " " + i);
            i++;
            if (i == 11) break;
        }


    }

}
