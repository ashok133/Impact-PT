var impactApp = new Vue({
	el: '#aggregatorDiv',
	data : {
			formQueries: [],
			queryUser: {
				firstName: '',
				lastName: '',
				email: '',
				queryType: '',
				queryMessage: ''
			},
			registerUser: {
				username: '',
				email: '',
				password: '',
				repeatPassword: '',
				phone: ''
			},
			logInUser: {
				username: '',
				password: ''
			},
			logInPhysician: {
				username: '',
				accessCode: ''
			}
		},
	  methods: {
			fetchQueries() {
				// console.log(document.getElementById("feedbackComment").value);
	      fetch('http://35.196.103.174/api/formQueries.php')
	      .then(response => response.json())
	      .then (json => {
					json.reverse();
					impactApp.formQueries = json;
					console.log(impactApp.formQueries);
				})
	      .catch( function(err){
	        console.log(err)
	      })
	    },
			submitFormResponse() {
				fetch('http://35.196.103.174/api/formQueries.php', {
				  method: 'POST',
				  body: JSON.stringify({
						firstName: impactApp.queryUser.firstName,
						lastName: impactApp.queryUser.lastName,
						email: impactApp.queryUser.email,
						queryType: impactApp.queryUser.queryType,
						queryMessage: impactApp.queryUser.queryMessage
					}),
				  headers:{
				    'Content-Type': 'application/json'
				  }
				}).then(response => response.json())
				.then(response => {
					alert(response);
				})
				.catch(error => console.error('Error:', error));
			},
			registerUserCall() {
				if (impactApp.registerUser.password !== impactApp.registerUser.repeatPassword) {
					alert("Please repeat the correct password and try again.")
					location.reload();
				}
				fetch('http://35.196.103.174/api/registerUser.php', {
				  method: 'POST',
				  body: JSON.stringify({
						request: 'register',
						username: impactApp.registerUser.username,
						firstName: impactApp.registerUser.firstName,
						lastName: impactApp.registerUser.lastName,
						email: impactApp.registerUser.email,
						password: impactApp.registerUser.password,
						phone: impactApp.registerUser.phone,
					}),
				  headers:{
				    'Content-Type': 'application/json'
				  }
				}).then(response => response.json())
				.then(response => {
					alert(response)
				})
				.catch(error => alert('Error:', error));
			},
			testAlert() {
				alert("Falala!");
			},
			logInUserCall() {
				fetch('http://35.196.103.174/api/registerUser.php', {
				  method: 'POST',
				  body: JSON.stringify({
						request: 'log-in',
						username: impactApp.logInUser.username,
						password: impactApp.logInUser.password,
					}),
				  headers:{
				    'Content-Type': 'application/json'
				  }
				}).then(response => response.json())
				.then(response => {
					alert(response);
					localStorage.clear();
					localStorage.setItem("username", impactApp.logInUser.username);
				})
				.catch(error => alert('Error:', error));
			},
			logInPhysicianCall() {
				fetch('http://35.196.103.174/api/registerUser.php', {
				  method: 'POST',
				  body: JSON.stringify({
						request: 'log-in-phy',
						username: impactApp.logInPhysician.username,
						accessCode: impactApp.logInPhysician.accessCode,
					}),
				  headers:{
				    'Content-Type': 'application/json'
				  }
				}).then(response => response.json())
				.then(response => {
					alert(response);
					localStorage.clear();
					localStorage.setItem("username", impactApp.logInPhysician.username);
					localStorage.setItem("role", "physician");
					window.open ('doctor_home.html', '_self', false)
				})
				.catch(error => alert('Error:', error));
			}
	  },
		created() {
			this.fetchQueries()
		}
	})
