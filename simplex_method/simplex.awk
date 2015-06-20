#!/usr/local/bin/gawk -f 
# simplex method
{
    #係数行列の読み込み
    row++;
    column = NF;
    for (j=1; j <= column; j++)
        a[row, j] = $j;

}

END {

    #最初のタブローを表示
    output();

    while(1) {

    #pivot決め 
        #pivotの列を探す
        numR = 100;
        columnnumber = 1;
        for(i=1; i<=column; i++) {
            if(a[row,i] < numR) {
                numR = a[row,i];
                columnnumber = i;
            }
        }

        #条件B
        if(numR >= 0) {
            printf("最適解です\n");
            #終了後のタブローを表示
            output();
            result();
            break;
        }

        #pivotの行を探す
        temp = 100;
        rownumber = 1;
        for(i=1; i<=row-1; i++) {
            if(a[i,columnnumber] > 0) {
                t = a[i,1] / a[i, columnnumber];
                if (t < temp) {
                    temp = t;
                    rownumber = i;
                }
            }
        }

        numC = 0;
        for(i=1; i<row; i++) {
            if(a[i,columnnumber] < 0) {
                numC = numC + 1;
            }
        }
        #条件A
        if(numC == row-1) {
            printf("最適解はないです\n");
            #終了後のタブローを表示
            output();
            break;
        }

        #pivotを見つける
        pivot = a[rownumber, columnnumber];

        #pivotでわる．
        for(i=1; i<=column; i++) {
            a[rownumber,i] = a[rownumber,i] / pivot;
        }

        #他の行の更新
        for(i=1; i<=row; i++) {
            if(rownumber != i) {
                v = a[i,columnnumber];
                for(j=1; j<=column; j++) {
                    a[i,j] = a[i,j] - a[rownumber,j] * v;
                }
            }
        }

    }
}

function output() {
    #行列の表示
    for (i=1; i<= row; i++) {
        for(j=1; j<= column; j++)
            printf("a[%d,%d]=%4.2f, ", i, j, a[i,j]);
        print "";
    }
    printf("\n");
}

function result() {
    #解の表示
    j=row;
    for(i=1; i<row; i++) {
        printf("X%d = %4.2f\n",i,a[--j,1])
    }
}
