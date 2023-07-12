def count_unique_names(names):
    unique_names = set()
    for name in names:
        individual_names = name.split(';')
        
        for individual_name in individual_names:
            lowercase_name = individual_name.lower().strip()
            unique_names.add(lowercase_name)
    
    return len(unique_names)



name_list = ["jeremy katz; gilad mor hayim", "Jeremy Katz", "doris pitilon; gilad mor hayim",
             "Doris Pitilon; Jeremy Katz"]

unique_name_count = count_unique_names(name_list)
print(unique_name_count)