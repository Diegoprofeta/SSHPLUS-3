for i in range(0,10):
  try:
  	data=$"msisdn=79998081034&campid=4919b47c-f588-4e71-87e3-639b3af92e4d&opCode=VV" && site=$"http://interatividade.vivo.ddivulga.com/carrotProcess" && curl "${site}" -d "${data}"
break
