# BASH Shell Tool for `event.dat` Data Analysis

Welcome to the BASH shell tool designed to analyze and display data from the `event.dat` file. The dataset in `event.dat` comprises elements structured as follows:

```
id|lastName|firstName|gender|birthday|joinDate|IP|browserUsed|socialmedia
```

---

## Features:

### 1. Display Student ID:

**Command**: 
```bash
./tool.sh
```

**Action**: 
Displays the Student-ID.

---

### 2. Fetch User Details by ID:

**Command**: 
```bash
./tool.sh -f -id [SPECIFIED_ID]
```

**Action**: 
Shows the first name, last name, and date of birth of the user corresponding to the specified ID.

---

### 3. List All First Names:

**Command**: 
```bash
./tool.sh --firstnames -f
```

**Action**: 
Displays all first names in the dataset, sorted alphabetically.

---

### 4. List All Last Names:

**Command**: 
```bash
./tool.sh --lastnames -f
```

**Action**: 
Showcases all last names in the dataset, alphabetically arranged.

---

### 5. Users Born Between Specified Dates:

**Command**: 
```bash
./tool.sh --born-since [START_DATE] --born-until [END_DATE] -f
```

**Action**: 
Lists the users who were born between the given start and end dates.

---

### 6. Display Social Media Platforms:

**Command**: 
```bash
./tool.sh --socialmedia -f
```

**Action**: 
Presents the different social media platforms used by the individuals in the dataset, sorted alphabetically.

---

## Usage:

1. Ensure you have `bash` installed and the `event.dat` file is present in the same directory as the `tool.sh` script.

2. Grant execution permissions to the script:
   ```bash
   chmod +x tool.sh
   ```

3. Use any of the aforementioned commands to interact with the `event.dat` data.

---
