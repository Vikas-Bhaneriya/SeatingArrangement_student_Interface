<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="connection.jsp" %>
<%
    
    class ClassBranch {
    String classid=null;
    String branch=null;
    int start,end,sem;

    ClassBranch(String classid, String branch, int sem, int start, int end){
        this.classid=classid;
        this.branch=branch;
        this.sem=sem;
        this.start=start;
        this.end=end;
    }
    }
    
   class  classdetail {
    String classname;
    int strength;
    int collumn;

    classdetail(){}
    public classdetail(String classname, int strength, int collumn) {

        this.classname = classname;
        this.strength = strength;
        this.collumn = collumn;

    }
    
}
  
String s1=request.getParameter("n1");
String s2=request.getParameter("n2");
String s3=request.getParameter("n3");

 switch(s1){
                case "Architecture": s1="Arch";
                    break;
                case "Information Technology":
                   s1="IT";
                    break;
                case "Mechanical Engineering":
                    s1="Mech";
                    break;
                case "Bio Medical Engineering":
                    s1="BM";
                    break;
                case "Bio Technology":
                    s1="BT";
                    break;
                case "Chemical Enginering":
                    s1="CHE";
                    break;
                case "Civil Engineering":
                    s1="CIVIL";
                    break;
                case "Computetr Science & Engineering":
                   s1="CS";
                    break;
                case "Electrical Engineering":
                  s1="EE";
                    break;
                case "Electronics & Telicom. Engineering":
                   s1="ELEX";
                    break;
                case "Mining":
                   s1="MINING";
                    break;
                case "Metallargical Engineering":
                  s1="META";
                    break;


 } 

   rs=stat.executeQuery("select * from classbranch where branch = '"+s1+"'and semester ='"+s2+"' and start <='"+s3+"'  and end >= '"+s3+"'");
   String name="";
   
   if(rs.next()){
       name=rs.getString("classid");
   }

    ArrayList<ClassBranch> list = new ArrayList<ClassBranch>();

    rs = stat.executeQuery("SELECT * FROM classbranch WHERE classid = '" + name + "'");
    while (rs.next()){
        String classid = rs.getString("classid");
        int start = rs.getInt("start");
        int end = rs.getInt("end");
        String branch =rs.getString("branch");
        int sem =rs.getInt("semester");
        list.add(new ClassBranch(classid,branch,sem,start,end));
    }
   
   rs = stat.executeQuery("select * from classdetail WHERE classid = '" + name +"'" );
   int strength=0,collum =1;
        if(rs.next()){
            strength = rs.getInt("strength");
            collum = rs.getInt("collumn");            
        }
  
    
    int row = (strength % collum == 0) ? strength / collum : (1 + (strength / collum));

    String[][] a = new String[30][30];

    Collections.sort(list, new Comparator<ClassBranch>() {
            @Override
            public int compare(ClassBranch lhs, ClassBranch rhs) {
                int x = lhs.end - lhs.start;
                int y = rhs.end - rhs.start;
                return (x > y) ? 1 : 0;
            }
        });



      
        boolean comeOut = false;
      
        int itemIndex = 0, i = 1, j = 1;

        ClassBranch cls = list.get(itemIndex);
        int amount = cls.end - cls.start + 1;
        int rollNo = cls.start;

        while (j <= collum) {                 
            boolean ff = false;
            while (a[i][j] != null && j <= collum) {
                while (a[i][j] != null) {
                    if (j % 2 != 0) {
                        if (a[i][j + 1] == null) {
                            j = j + 1;
                            ff = true;
                            break;
                        }
                    } else {
                        if (a[i][j - 1] == null) {
                            j = j - 1;
                            ff = true;
                            break;
                        }
                    }
                    i++;
                    if (i > row) i = i % row;
                }
                if (ff) break;
                j += 2;
                if (j > collum) j = j % collum;
            }
            while (i <= row) {                    
                a[i][j] = cls.branch+"("+cls.sem+")"+"-" + rollNo;
                rollNo++;
              
                amount--;
                if (amount == 0) {
                    itemIndex += 1;
                    if (itemIndex == list.size()) {
                        comeOut = true;
                        break;                           
                    }
                    cls = list.get(itemIndex);
                    amount = cls.end - cls.start + 1;
                    rollNo = cls.start;                  
                }
                if (j % 2 == 0) j--;
                else j++;
                i += 2;
                if (i > row) {
                    i = i % row;
                    break;
                }
            }
            if (comeOut) break;
            j += 2;
            if (j > collum) j = j % collum;
        }

      
        
%>


<html><center>
     <style>
body {background-color: powderblue;}
h1   {color: blue;}
p    {color: red;}
</style>


<head>
        <link rel="stylesheet" href="styles.css">
        <p>  <h2>National Institute Of Technology<h2></p>
        
      <p>  <h1>Your Seat is in Class <% out.print(name);%><h1></p>
                  
                  
    </head>
    
  
    
    
    
    
    
    <body>

 
    
    <style>
table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    text-align: left;
    padding: 8px;
}

tr:nth-child(even){background-color: #f2f2f2}
</style>
    
    
    <div style="overflow-x:auto;">
    <table>
         <tr>
             
             
            <% for (i = 1; i <= collum; i++) { %>
            
            
      <th> <% out.print ("collumn "+i); %></th>
      <%
      
      }%>
      
    </tr>
       
        
        <%
           for (i = 1; i <= row; i++) {
             %><tr><%
            for (j= 1; j <= collum; j++) {
              
                 String sub = a[i][j].substring(a[i][j].indexOf("-")+1);
                 int rno = Integer.parseInt(sub);
                    
                 if(rno==Integer.parseInt(s3)){
              %>
<td bgcolor="#ff9cce" > <% out.print(a[i][j] +"") ; %></td>
        <% }
else{
             %>
                
             <td>
                                  

                 <%
                    out.print(a[i][j] +""); }%></td>
                <%
                
            }  %>
       </tr>
          <%
        }
        %>
        
        </table>
    </div>
        </body>
        
        </center>
        
        </html>
        
        
        
        
        
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="connection.jsp" %>
<%
    
    class ClassBranch {
    
            String classid=null;
    String branch=null;
    int start=0,end=0,sem=0,sliderStart=0,sliderEnd=0;

    ClassBranch(String classid, String branch, int sem, int start, int end,int sliderStart,int sliderEnd){
        this.classid=classid;
        this.branch=branch;
        this.sem=sem;
        this.start=start;
        this.end=end;
        this.sliderEnd=sliderEnd;
        this.sliderStart=sliderStart;
    }
        
    }
    
   class  classdetail {
    String classname;
    int strength;
    int collumn;

    public classdetail(){}
    public classdetail(String classname, int strength, int collumn) {

        this.classname = classname;
        this.strength = strength;
        this.collumn = collumn;

    }
    
}
  
String s1=request.getParameter("n1");
String s2=request.getParameter("n2");
String s3=request.getParameter("n3");

 switch(s1){
                case "Architecture": s1="Arch";
                    break;
                case "Information Technology":
                   s1="IT";
                    break;
                case "Mechanical Engineering":
                    s1="Mech";
                    break;
                case "Bio Medical Engineering":
                    s1="BM";
                    break;
                case "Bio Technology":
                    s1="BT";
                    break;
                case "Chemical Enginering":
                    s1="CHE";
                    break;
                case "Civil Engineering":
                    s1="CIVIL";
                    break;
                case "Computetr Science & Engineering":
                   s1="CS";
                    break;
                case "Electrical Engineering":
                  s1="EE";
                    break;
                case "Electronics & Telicom. Engineering":
                   s1="ELEX";
                    break;
                case "Mining":
                   s1="MINING";
                    break;
                case "Metallargical Engineering":
                  s1="META";
                    break;


 } 
 
 
       int k=Integer.parseInt(s3);

   rs=stat.executeQuery("select * from classbranch where  (start <='" + k+ "'  and end >= '" + k + "') OR (sliderstart <='" + k + "'  and sliderend >= '" + k + "')    ");
   String name="";
   
   if(rs.next()){
       name=rs.getString("classid");
   }

    ArrayList<ClassBranch> list = new ArrayList<>();

    rs = stat.executeQuery("SELECT * FROM classbranch WHERE classid = '" + name + "'");
    while (rs.next()){
        String classid = rs.getString("classid");
        int start = rs.getInt("start");
        int end = rs.getInt("end");
        String branch =rs.getString("branch");
        int sem =rs.getInt("semester");
        int sliderstart=rs.getInt("sliderstart");
        
        int sliderend=rs.getInt("sliderend");
        list.add(new ClassBranch(classid,branch,sem,start,end,sliderstart,sliderend));
        
    }
   
   rs = stat.executeQuery("select * from classdetail WHERE classid = '" + name +"'" );
   int strength=0,collum =1;
        if(rs.next()){
            strength = rs.getInt("strength");
            collum = rs.getInt("collumn");            
        }
  
    
    int row = (strength % collum == 0) ? strength / collum : (1 + (strength / collum));

    String[][] a = new String[50][50];

    Collections.sort(list, new Comparator<ClassBranch>() {
            @Override
            public int compare(ClassBranch lhs, ClassBranch rhs) {
                int x = lhs.end - lhs.start;
                int y = rhs.end - rhs.start;
                return (x > y) ? 1 : 0;
            }
        });



      
     boolean comeOut = false,flag= false;
          
      
        int itemIndex = 0, i = 1, j = 1;

        ClassBranch cls = list.get(itemIndex);
        int amount = cls.end - cls.start + 1;
        int rollNo = cls.start;
        if(cls.sliderStart!=0)
            flag=true;

        while (j <= collum) {                 
            boolean ff = false;
            while (a[i][j] != null && j <= collum) {
                while (a[i][j] != null) {
                    if (j % 2 != 0) {
                        if (a[i][j + 1] == null) {
                            j = j + 1;
                            ff = true;
                            break;
                        }
                    } else {
                        if (a[i][j - 1] == null) {
                            j = j - 1;
                            ff = true;
                            break;
                        }
                    }
                    i++;
                    if (i > row) i = i % row;
                }
                if (ff) break;
                j += 2;
                if (j > collum) j = j % collum;
            }
            while (i <= row) {                    
                a[i][j] = cls.branch+"("+cls.sem+")"+"-" + rollNo;
                rollNo++;
              
                amount--;
                if (amount == 0) {
                    
                   ClassBranch x=list.get(itemIndex);
                    if(flag){
                        rollNo=x.sliderStart;
                        amount=x.sliderEnd-x.sliderStart+1;
                        flag=false;
                    }else {
                        itemIndex += 1;
                        if (itemIndex == list.size()) {
                            comeOut = true;
                            break;                             // goto outside
                        }
                        cls = list.get(itemIndex);
                        amount = cls.end - cls.start + 1;
                    
                }
                if (j % 2 == 0) j--;
                else j++;
                i += 2;
                if (i > row) {
                    i = i % row;
                    break;
                }
            }
            if (comeOut) break;
            j += 2;
            if (j > collum) j = j % collum;
        }

      
        
%>


<html><center>
     <style>
body {background-color: powderblue;}
h1   {color: blue;}
p    {color: red;}
</style>


<head>
        <link rel="stylesheet" href="styles.css">
        <p>  <h2>National Institute Of Technology<h2></p>
        
      <p>  <h1>Your Seat is in Class <% out.print(name);%><h1></p>
                  
                  
    </head>
    <body>

 
    
    <style>
table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    text-align: left;
    padding: 8px;
}

tr:nth-child(even){background-color: #f2f2f2}
</style>
    
    
    <div style="overflow-x:auto;">
    <table>
         <tr>
             
             
            <% for (i = 1; i <= collum; i++) { %>
            
            
      <th> <% out.print ("collumn "+i); %></th>
      <%
      
      }%>
      
    </tr>
       
        
        <%
           for (i = 1; i <= row; i++) {
             %><tr><%
            for (j= 1; j <= collum; j++) {
              
                 String sub = a[i][j].substring(a[i][j].indexOf("-")+1);
                 int rno = Integer.parseInt(sub);
                    
                 if(rno==Integer.parseInt(s3)){
              %>
<td bgcolor="#ff9cce" > <% out.print(a[i][j] +"") ; %></td>
        <% }
else{
             %>
                
             <td>
                                  

                 <%
                    out.print(a[i][j] +""); }%></td>
                <%
                
            }  %>
       </tr>
          <%
        }
        %>
        
        </table>
    </div>
        </body>
        
        </center>
        
        </html>
        
        
        
        
        