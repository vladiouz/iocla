#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "structs.h"

void get_operations(void** operations);

// functie care e apelata atunci cand gasim un sensor cu date gresite
sensor* remove_sensor(sensor* array, int no_sensors, int index)
{
    sensor* temp = malloc((no_sensors - 1) * sizeof(sensor));

    if (index != 0)
	{
        memcpy(temp, array, index * sizeof(sensor));
	}
    
	if (index != (no_sensors - 1))
    {
	    memcpy(temp+index, array+index+1, (no_sensors - index - 1) * sizeof(sensor));
	}

	int i;

	for(i = 0; i < no_sensors; i++)
	{
		free(array[i].operations_idxs);
		free(array[i].sensor_data);
	}

	free(array);
    return temp;
}

// functie pentru qsort
int comparator(const void *a, const void *b)
{
	int p = ((sensor *)a)->sensor_type;
	int u = ((sensor *)b)->sensor_type;
	return (u - p);
}

int main(int argc, char const *argv[])
{
	FILE *fin = fopen(argv[1], "rb");

	int no_sensors, i, j;
	char *buffer = malloc(20 * sizeof(char));
	sensor* sensors;

	// vom folosi operations pentru a accesa toate operatiile atunci cand facem analyse
	void (*operations[8])(void *);

	fread(&no_sensors, sizeof(int), 1, fin);
	sensors = (sensor *)malloc(no_sensors * (sizeof(sensor)));

	for(i = 0; i < no_sensors; i++)
	{
		fread(&sensors[i].sensor_type, sizeof(int), 1, fin);

		// sensor de tip Tire
		if(sensors[i].sensor_type == 0)
		{
			sensors[i].sensor_data = malloc(sizeof(tire_sensor));

			fread(&((tire_sensor *)sensors[i].sensor_data)->pressure, sizeof(float), 1, fin);
			fread(&((tire_sensor *)sensors[i].sensor_data)->temperature, sizeof(float), 1, fin);
			fread(&((tire_sensor *)sensors[i].sensor_data)->wear_level, sizeof(int), 1, fin);
			fread(&((tire_sensor *)sensors[i].sensor_data)->performace_score, sizeof(int), 1, fin);

		// sensor de tip PMU
		} else {
			sensors[i].sensor_data = malloc(sizeof(power_management_unit));

			fread(&((power_management_unit *)sensors[i].sensor_data)->voltage, sizeof(float), 1, fin);
			fread(&((power_management_unit *)sensors[i].sensor_data)->current, sizeof(float), 1, fin);
			fread(&((power_management_unit *)sensors[i].sensor_data)->power_consumption, sizeof(float), 1, fin);
			fread(&((power_management_unit *)sensors[i].sensor_data)->energy_regen, sizeof(int), 1, fin);
			fread(&((power_management_unit *)sensors[i].sensor_data)->energy_storage, sizeof(int), 1, fin);
		}

		fread(&sensors[i].nr_operations, sizeof(int), 1, fin);
		sensors[i].operations_idxs = malloc(sensors[i].nr_operations * sizeof(int));

		for(j = 0; j < sensors[i].nr_operations; j++)
		{
			fread(&sensors[i].operations_idxs[j], sizeof(int), 1, fin);	
		}
	}

	// sortam vectorul sensors astfel incat sensorii de tip PMU vor fi primii
	qsort(sensors, no_sensors, sizeof(sensor), comparator);

	get_operations((void **)operations);

	while(scanf("%s", buffer))
	{
		if(strcmp(buffer, "exit") == 0)
		{
			// dezalocam tot
			for(i = 0; i < no_sensors; i++)
			{
				free(sensors[i].operations_idxs);
				free(sensors[i].sensor_data);
			}
			free(buffer);
			free(sensors);
			break;
		} else if(strcmp(buffer, "clear") == 0)
		{
			i = 0;
			while(i < no_sensors)
			{
				// verificam daca datele sunt corecte sau nu
				// daca nu sunt corecte, apelam remove_sensor
				if(sensors[i].sensor_type == 0)
				{
					if(((tire_sensor *)sensors[i].sensor_data)->pressure < 19 || ((tire_sensor *)sensors[i].sensor_data)->pressure > 28)
					{
						sensors = remove_sensor(sensors, no_sensors, i);
						no_sensors--;
					} else if(((tire_sensor *)sensors[i].sensor_data)->temperature < 0 || ((tire_sensor *)sensors[i].sensor_data)->temperature > 120)
					{
						sensors = remove_sensor(sensors, no_sensors, i);
						no_sensors--;
					} else if(((tire_sensor *)sensors[i].sensor_data)->wear_level < 0 || ((tire_sensor *)sensors[i].sensor_data)->wear_level > 100)
					{
						sensors = remove_sensor(sensors, no_sensors, i);
						no_sensors--;
					} else {
						i++;
					}
				} else {
					if(((power_management_unit *)sensors[i].sensor_data)->voltage < 10 || ((power_management_unit *)sensors[i].sensor_data)->voltage > 20)
					{
						sensors = remove_sensor(sensors, no_sensors, i);
						no_sensors--;
					} else if(((power_management_unit *)sensors[i].sensor_data)->current < -100 || ((power_management_unit *)sensors[i].sensor_data)->current > 100)
					{
						sensors = remove_sensor(sensors, no_sensors, i);
						no_sensors--;
					} else if(((power_management_unit *)sensors[i].sensor_data)->power_consumption < 0 || ((power_management_unit *)sensors[i].sensor_data)->power_consumption > 1000)
					{
						sensors = remove_sensor(sensors, no_sensors, i);
						no_sensors--;
					} else if(((power_management_unit *)sensors[i].sensor_data)->energy_regen < 0 || ((power_management_unit *)sensors[i].sensor_data)->energy_regen > 100)
					{
						sensors = remove_sensor(sensors, no_sensors, i);
						no_sensors--;
					} else if(((power_management_unit *)sensors[i].sensor_data)->energy_storage < 0 || ((power_management_unit *)sensors[i].sensor_data)->energy_storage > 100)
					{
						sensors = remove_sensor(sensors, no_sensors, i);
						no_sensors--;
					} else {
						i++;
					}
				}
			}

		} else if(strcmp(buffer, "print") == 0) {
			scanf("%d", &i);
			
			if(i < 0 || i >= no_sensors)
			{
				printf("Index not in range!\n");
			} else if(sensors[i].sensor_type == 0)
			{
				printf("Tire Sensor\n");
				printf("Pressure: %.2f\n", ((tire_sensor *)sensors[i].sensor_data)->pressure);
				printf("Temperature: %.2f\n", ((tire_sensor *)sensors[i].sensor_data)->temperature);
				printf("Wear Level: %d%%\n", ((tire_sensor *)sensors[i].sensor_data)->wear_level);

				if(((tire_sensor *)sensors[i].sensor_data)->performace_score)
				{
					printf("Performance Score: %d\n", ((tire_sensor *)sensors[i].sensor_data)->performace_score);
				} else {
					printf("Performance Score: Not Calculated\n");
				}
			} else {
				printf("Power Management Unit\n");
				printf("Voltage: %.2f\n", ((power_management_unit *)sensors[i].sensor_data)->voltage);			
				printf("Current: %.2f\n", ((power_management_unit *)sensors[i].sensor_data)->current);
				printf("Power Consumption: %.2f\n", ((power_management_unit *)sensors[i].sensor_data)->power_consumption);
				printf("Energy Regen: %d%%\n", ((power_management_unit *)sensors[i].sensor_data)->energy_regen);
				printf("Energy Storage: %d%%\n", ((power_management_unit *)sensors[i].sensor_data)->energy_storage);
			}
		} else {
			scanf("%d", &i);

			if(i < 0 || i >= no_sensors)
			{
				printf("Index not in range!\n");
			} else {
				for(j = 0; j < sensors[i].nr_operations; j++)
				{
					operations[sensors[i].operations_idxs[j]](sensors[i].sensor_data);
				}
			}
		}
	}

	fclose(fin);
	return 0;
}
