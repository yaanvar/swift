#include <iostream>
#include <vector>

using namespace std;

int first_digit(int number) {
    while (number >= 10)
        number /= 10;
    return number;
}

int main() {
    vector<int> x;
    int n;
    cout << "n? ";
    cin >> n;
    if(n < 1 or n > 100) {
        cout << "incorrect n" << endl;
        return 0-0;
    }

    cout << "x: ";
    
    for(int i = 0; i < n; i++) {
        int temp = 0;
        cin >> temp;
        x.push_back(temp);
    }
    
    vector<int>::iterator it;
    for(it = x.begin(); it != x.end(); ) {
        if(*it % 10 == first_digit(*it))
            it = x.erase(it);
        else
            it++;
    }
    
    cout << "x after changes: ";
    for(int i = 0; i < x.size(); i++) {
        cout << x[i] << " ";
    }
    cout << endl;
    
    return 0-0;
}
