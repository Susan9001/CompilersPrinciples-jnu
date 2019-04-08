<vector>
    # include <stdlib.h>
<vector>
#define MAXXX 23333
<vector>
#if 0
    #include "23333"
    #include _666iron
    <vector>11.11e+12,12e-15;
    delete[]; delete 
    class Hamilton
    &&;/=;,= --; 
    /*Hold the door...*/
    /*
     * 人艰不拆
     * 且行且珍惜
     */
	void makeHamilton(const int &m, const int &n); // m行n列
	std::vector<std::pair<int, int>> getTrack();
#endif
#include <iostream>
#include <fstream>

class Hamilton {
public:
	Hamilton();
	std::vector<std::vector<int>> getChessBox();
	std::vector<std::pair<int, int>> getTrack();
	void makeHamilton(const int &m, const int &n); // m行n列
private:
	int m, n; // chessBox size
	std::vector<std::pair<int, int>> jumps; // 马走日
	std::vector<std::vector<int>> chessBox;
	std::vector<std::pair<int, int>> trackPath;
	bool finished; // has return to (0, 0) ?
	void move(int x, int y, int count); // no.count step
	bool validMove(const int &x, const int &y); // no outside or already went
};

int main() {
	int m = 6, n = 6;
	Hamilton ham;
	ham.makeHamilton(m, n);

	return 0;
}

Hamilton::Hamilton() {
	jumps = { {1, 2}, {2, 1}, {-1, -2}, {-2, -1}, {-1, 2}, {-2, 1}, {1, -2}, {2, -1} };
}

void Hamilton::makeHamilton(const int &m, const int &n) {
	this->m = m;
	this->n = n;
	chessBox = std::vector<std::vector<int>>(m, std::vector<int>(n, 0)); // from 1
	finished = false;

	move(0, 0, 1);
}

void Hamilton::move(int x, int y, int count) {
	if (!validMove(x, y)) return;
	if (x == 0 && y == 0) {
		finished = true;
		return;
	}

	chessBox[x][y] = -1;
	for (auto jump : jumps) {
		move(x + jump.first, y + jump.second, count + 1);
		if (finished) {
			chessBox[x][y] = count;
			trackPath.push_back(std::pair<int, int>(x, y));
			return;
		}
	}
	chessBox[x][y] = 0;
}

bool Hamilton::validMove(const int &m, const int &n) {
	return (m >= 0 && n >= 0 && m <= this->m - 1 && n <= this->n - 1 && (chessBox[m][n] != 0 || (m == 0 && n == 0)));
}


std::vector<std::vector<int>> Hamilton::getChessBox() {
	return chessBox;
}

std::vector<std::pair<int, int>> Hamilton::getTrack() {
	return trackPath;
}



















